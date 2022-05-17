#import "VeSpringBoard.h"

%group Ve

%hook BBServer

- (void)publishBulletin:(id)arg1 destinations:(unsigned long long)arg2 { // catch incoming notifications

	%orig;

	BOOL isLoggingTemporarilyDisabled = [[preferences valueForKey:@"isLoggingTemporarilyDisabled"] boolValue];
	if (isLoggingTemporarilyDisabled) return;
	
	BBBulletin* bulletin = arg1;

	// NSLog(@"[VE] default: %@", [bulletin defaultAction]);
	// NSLog(@"[VE] launchurl: %@", [[bulletin defaultAction] launchURL]);
	// NSLog(@"[VE] actions: %@", [bulletin actions]);

	HBPreferences* logs = [[HBPreferences alloc] initWithIdentifier:@"love.litten.ve-logs"];

	// prevent duplicates
	if ([[[logs objectForKey:@"loggedNotifications"] valueForKey:@"date"] containsObject:[bulletin date]]) { 
		return;
	}

	// return if the notification comes from a blocked bundle identifier or contains an excluded phrase
	NSArray* blockedBundleIdentifiers = [logs objectForKey:@"blockedBundleIdentifiers"];
	NSArray* excludedPhrases = [logs objectForKey:@"excludedPhrases"];
	if ([blockedBundleIdentifiers count] > 0 || [excludedPhrases count] > 0) {
		if ([blockedBundleIdentifiers containsObject:[arg1 sectionID]]) return;

		for (NSString* phrase in excludedPhrases) {
			if ([[bulletin title] localizedCaseInsensitiveContainsString:phrase] || [[bulletin message] localizedCaseInsensitiveContainsString:phrase]) return;
		}
	}

	if ([bulletin sectionID]) { // save the incoming notification and its details
		if (!logMessagesWithoutContentSwitch && (![bulletin message] || [[bulletin message] isEqualToString:@""])) return;

		NSMutableArray* attachments = nil;
		// save all attachments
		if (saveAttachmentsSwitch) {
			NSURL* attachmentsURL = [[[bulletin primaryAttachment] URL] URLByDeletingLastPathComponent];
			NSString* attachmentsDirectoryPath = [[attachmentsURL absoluteString] stringByReplacingOccurrencesOfString:@"file://" withString:@""];
			NSArray* attachmentsDirectory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:attachmentsDirectoryPath error:nil];
			attachments = [NSMutableArray new];
			for (int i = 0; i < [attachmentsDirectory count]; i++) {
				NSFileManager* fileManager = [NSFileManager defaultManager];
				BOOL isDirectory;

				// create the main attachments directory if it doesn't exist already
				NSString* mainDirectoryPath = @"/var/mobile/Media/Vē/";
				if (![fileManager fileExistsAtPath:mainDirectoryPath isDirectory:&isDirectory])
					[fileManager createDirectoryAtPath:mainDirectoryPath withIntermediateDirectories:YES attributes:nil error:nil];

				// create a directory named after the notification's bundle identifier if it doesn't exist already
				NSString* directoryPath = [NSString stringWithFormat:@"%@%@/", mainDirectoryPath, [bulletin sectionID]];
				if (![fileManager fileExistsAtPath:directoryPath isDirectory:&isDirectory])
					[fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];

				NSString* fileName = [attachmentsDirectory objectAtIndex:i];
				NSString* filePath = [NSString stringWithFormat:@"%@%@", attachmentsDirectoryPath, fileName];
				NSData* attachmentData = UIImageJPEGRepresentation([UIImage imageWithContentsOfFile:filePath], 1);
				NSString* saveFileName = [[NSString stringWithFormat:@"%@%@", [NSDate date], fileName] stringByReplacingOccurrencesOfString:@" " withString:@""];
				[attachmentData writeToFile:[NSString stringWithFormat:@"%@%@/%@", mainDirectoryPath, [bulletin sectionID], saveFileName] atomically:YES];

				// save the attachments names to an array to access them later
				[attachments addObject:saveFileName];
			}
		}

		NSMutableArray* newLogs = [NSMutableArray new];
		// create the log
		[newLogs addObject:@{
			@"identifier" : [NSNumber numberWithUnsignedInteger:(NSUInteger)[[logs objectForKey:@"lastHighestID"] intValue] + 1],
			@"bundleID" : [bulletin sectionID] ?: @"",
			@"displayName" : [[[%c(SBApplicationController) sharedInstance] applicationWithBundleIdentifier:[bulletin sectionID]] displayName] ?: @"",
			@"title" : [bulletin title] ?: @"",
			@"message" : [bulletin message] ?: @"",
			@"attachments" : attachments ?: [NSArray new],
			@"date" : [bulletin date] ?: [NSDate date]
		}];

		// add all other stored logs
		[newLogs addObjectsFromArray:[logs objectForKey:@"loggedNotifications"]];

		if (entryLimitValue > 1 && [newLogs count] >= entryLimitValue) { // delete all logs that are above the entry limit, if one is set
			while ([newLogs count] > entryLimitValue) {
				[newLogs removeLastObject];
			}
		}

		[logs setObject:newLogs forKey:@"loggedNotifications"];

		NSUInteger totalLoggedNotificationCount = [[logs objectForKey:@"totalLoggedNotificationCount"] intValue];
		NSUInteger lastHighestID = [[logs objectForKey:@"lastHighestID"] intValue];
		[logs setUnsignedInteger:(totalLoggedNotificationCount += 1)  forKey:@"totalLoggedNotificationCount"];
		[logs setUnsignedInteger:(lastHighestID += 1)  forKey:@"lastHighestID"];
	}


	// delete logs after the set amount of days
	if (deleteLogsAutomaticallySwitch) {
		if (![[NSCalendar currentCalendar] isDateInToday:[logs objectForKey:@"lastHouseholdDate"]] || ![logs objectForKey:@"lastHouseholdDate"]) { // only do this once a day (or if it's the first time ever), unless no notification comes in that day, then don't
			[logs setObject:[NSDate date] forKey:@"lastHouseholdDate"];
			NSMutableArray* currentlyStoredLogs = [[logs objectForKey:@"loggedNotifications"] mutableCopy];

			// this part runs on the background thread in case there's a ton of logged notifications that need to be looped trough
			dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0ul), ^{
				for (int i = 0; i < [currentlyStoredLogs count]; i++) {
					NSDictionary* log = [currentlyStoredLogs objectAtIndex:i];
					NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
					NSDateComponents* components = [calendar components:NSCalendarUnitDay fromDate:[log objectForKey:@"date"] toDate:[NSDate date] options:0];

					if ([components day] > deleteLogsAutomaticallyAfterDaysValue) {
						NSDictionary* log = [currentlyStoredLogs objectAtIndex:i];
						// delete all attachments before deleting the log
						NSFileManager* fileManager = [NSFileManager defaultManager];
						for (NSString* attachment in [log objectForKey:@"attachments"])
							[fileManager removeItemAtPath:[NSString stringWithFormat:@"/var/mobile/Media/Vē/%@/%@", [log objectForKey:@"bundleID"], attachment] error:nil];

						[currentlyStoredLogs removeObjectAtIndex:i];
					}
				}

				[logs setObject:currentlyStoredLogs forKey:@"loggedNotifications"];
			});
		}
	}

}

%end

%hook BBAction

- (void)setCallblock:(id)arg1 {
	%orig;
	NSLog(@"[VE] callblock: %@", arg1);
}

%end

%end

%ctor {

	preferences = [[HBPreferences alloc] initWithIdentifier:@"love.litten.vepreferences"];

	[preferences registerBool:&enabled default:NO forKey:@"Enabled"];
	if (!enabled) return;

	// logs
	[preferences registerBool:&logMessagesWithoutContentSwitch default:NO forKey:@"logMessagesWithoutContent"];

	// attachments
	[preferences registerBool:&saveAttachmentsSwitch default:YES forKey:@"saveAttachments"];

	// household
	[preferences registerUnsignedInteger:&entryLimitValue default:1 forKey:@"entryLimit"];
	[preferences registerBool:&deleteLogsAutomaticallySwitch default:YES forKey:@"deleteLogsAutomatically"];
	[preferences registerUnsignedInteger:&deleteLogsAutomaticallyAfterDaysValue default:31 forKey:@"deleteLogsAutomaticallyAfterDays"];

	%init(Ve);

}
