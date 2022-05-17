#import "VeDetailViewListController.h"

@implementation VeDetailViewListController

- (void)viewDidLoad { // add a grabber

    [super viewDidLoad];


    // grabber
    self.grabber = [_UIGrabber new];
    [[self view] addSubview:[self grabber]];

    [[self grabber] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.grabber.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:12],
        [self.grabber.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
    ]];

}

- (NSArray *)specifiers {  // list all details

    _specifiers = [NSMutableArray new];


    // details
    [_specifiers addObject:[PSSpecifier groupSpecifierWithName:@"Details"]];

    PSSpecifier* identifierSpecifier = [PSSpecifier preferenceSpecifierNamed:nil target:self set:nil get:nil detail:nil cell:PSButtonCell edit:nil];
    [identifierSpecifier setProperty:[VeDetailCell class] forKey:@"cellClass"];
    [identifierSpecifier setButtonAction:@selector(copyContent:)];
    [identifierSpecifier setProperty:@"Identifier" forKey:@"title"];
    [identifierSpecifier setProperty:[NSString stringWithFormat:@"%lu", [self notificationID]] forKey:@"content"];
    [_specifiers addObject:identifierSpecifier];

    PSSpecifier* bundleIDSpecifier = [PSSpecifier preferenceSpecifierNamed:nil target:self set:nil get:nil detail:nil cell:PSButtonCell edit:nil];
    [bundleIDSpecifier setProperty:[VeDetailCell class] forKey:@"cellClass"];
    [bundleIDSpecifier setButtonAction:@selector(copyContent:)];
    [bundleIDSpecifier setProperty:@"Bundle Identifier" forKey:@"title"];
    [bundleIDSpecifier setProperty:[self notificationBundleID] forKey:@"content"];
    [_specifiers addObject:bundleIDSpecifier];

    PSSpecifier* displayNameSpecifier = [PSSpecifier preferenceSpecifierNamed:nil target:self set:nil get:nil detail:nil cell:PSButtonCell edit:nil];
    [displayNameSpecifier setProperty:[VeDetailCell class] forKey:@"cellClass"];
    [displayNameSpecifier setButtonAction:@selector(copyContent:)];
    [displayNameSpecifier setProperty:@"Application" forKey:@"title"];
    [displayNameSpecifier setProperty:[self notificationDisplayName] forKey:@"content"];
    [_specifiers addObject:displayNameSpecifier];

    PSSpecifier* titleSpecifier = [PSSpecifier preferenceSpecifierNamed:nil target:self set:nil get:nil detail:nil cell:PSButtonCell edit:nil];
    [titleSpecifier setProperty:[VeDetailCell class] forKey:@"cellClass"];
    [titleSpecifier setButtonAction:@selector(copyContent:)];
    [titleSpecifier setProperty:@"Title" forKey:@"title"];
    [titleSpecifier setProperty:[self notificationTitle] forKey:@"content"];
    [_specifiers addObject:titleSpecifier];

    PSSpecifier* messageSpecifier = [PSSpecifier preferenceSpecifierNamed:nil target:self set:nil get:nil detail:nil cell:PSButtonCell edit:nil];
    [messageSpecifier setProperty:[VeDetailCell class] forKey:@"cellClass"];
    [messageSpecifier setButtonAction:@selector(expandMessage:)];
    [messageSpecifier setProperty:@"Message" forKey:@"title"];
    [messageSpecifier setProperty:[self notificationMessage] forKey:@"content"];
    [_specifiers addObject:messageSpecifier];

    NSDateFormatter* dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:[NSString stringWithFormat:@"EEEE, %@ %@", [self dateFormat], [self timeFormat]]];
    PSSpecifier* dateSpecifier = [PSSpecifier preferenceSpecifierNamed:nil target:self set:nil get:nil detail:nil cell:PSButtonCell edit:nil];
    [dateSpecifier setProperty:[VeDetailCell class] forKey:@"cellClass"];
    [dateSpecifier setButtonAction:@selector(copyContent:)];
    [dateSpecifier setProperty:@"Date" forKey:@"title"];
    [dateSpecifier setProperty:[dateFormat stringFromDate:[self notificationDate]] forKey:@"content"];
    [_specifiers addObject:dateSpecifier];

    if ([[self notificationAttachments] count] > 0) {
        [_specifiers addObject:[PSSpecifier groupSpecifierWithName:@"Attachments"]];

        for (int i = 0; i < [[self notificationAttachments] count]; i++) {
            PSSpecifier* attachmentSpecifier = [PSSpecifier preferenceSpecifierNamed:nil target:self set:nil get:nil detail:nil cell:PSButtonCell edit:nil];
            [attachmentSpecifier setProperty:[VeDetailAttachmentCell class] forKey:@"cellClass"];
            [attachmentSpecifier setButtonAction:@selector(presentAttachment:)];
            [attachmentSpecifier setProperty:@(YES) forKey:@"enabled"];
            [attachmentSpecifier setProperty:@"70" forKey:@"height"];
            [attachmentSpecifier setProperty:[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"/var/mobile/Media/Vē/%@/%@", [self notificationBundleID], [[self notificationAttachments] objectAtIndex:i]]] forKey:@"attachmentData"];
            [attachmentSpecifier setProperty:[NSString stringWithFormat:@"%d", i + 1] forKey:@"attachmentIndex"];
            [_specifiers addObject:attachmentSpecifier];
        }
    }


    // actions
    if (![[self notificationDisplayName] isEqualToString:@""]) {
        [_specifiers addObject:[PSSpecifier groupSpecifierWithName:@"Actions"]];

        PSSpecifier* openAppSpecifier = [PSSpecifier preferenceSpecifierNamed:[NSString stringWithFormat:@"Open %@", [self notificationDisplayName]] target:self set:nil get:nil detail:nil cell:PSButtonCell edit:nil];
        [openAppSpecifier setButtonAction:@selector(openApplication)];
        [_specifiers addObject:openAppSpecifier];
    }


    // danger zone
    [_specifiers addObject:[PSSpecifier groupSpecifierWithName:@"Danger Zone"]];

    HBPreferences* logs = [[HBPreferences alloc] initWithIdentifier:@"love.litten.ve-logs"];
    PSSpecifier* blockSpecifier = [PSSpecifier deleteButtonSpecifierWithName:[[logs objectForKey:@"blockedBundleIdentifiers"] containsObject:[self notificationBundleID]] ? @"Unblock Bundle Identifier" : @"Block Bundle Identifier" target:self action:@selector(blockBundleIdentifier)];
    [_specifiers addObject:blockSpecifier];

    PSSpecifier* deleteSpecifier = [PSSpecifier deleteButtonSpecifierWithName:@"Delete Log" target:self action:@selector(deleteLog)];
    [_specifiers addObject:deleteSpecifier];


	return _specifiers;

}

- (BOOL)shouldReloadSpecifiersOnResume { // prevent the controller from reloading the view after inactivity

    return false;

}

- (void)copyContent:(PSSpecifier *)specifier { // copy the content of the selected specifier

    [[UIPasteboard generalPasteboard] setString:specifier.properties[@"content"]];

}

- (void)expandMessage:(PSSpecifier *)specifier {

    VeDetailMessageListController* messageListController = [VeDetailMessageListController new];
    [messageListController setMessage:specifier.properties[@"content"]];
    [self presentViewController:messageListController animated:YES completion:nil];

}

- (void)presentAttachment:(PSSpecifier *)specifier { // present the full attachment

    VeDetailAttachmentListController* attachmentListController = [VeDetailAttachmentListController new];
    [attachmentListController setAttachmentData:[NSData dataWithData:specifier.properties[@"attachmentData"]]];
    [self presentViewController:attachmentListController animated:YES completion:nil];

}

- (void)openApplication { // open the application

    [[objc_getClass("LSApplicationWorkspace") defaultWorkspace] openApplicationWithBundleID:[self notificationBundleID]];

}

- (void)blockBundleIdentifier { // block/unblock the current bundle identifier

    HBPreferences* logs = [[HBPreferences alloc] initWithIdentifier:@"love.litten.ve-logs"];
    NSMutableArray* blockedBundleIdentifiers = [NSMutableArray new];
    [blockedBundleIdentifiers addObjectsFromArray:[logs objectForKey:@"blockedBundleIdentifiers"]];

    if ([blockedBundleIdentifiers containsObject:[self notificationBundleID]]) [blockedBundleIdentifiers removeObject:[self notificationBundleID]];
    else [blockedBundleIdentifiers addObject:[self notificationBundleID]];

    [logs setObject:blockedBundleIdentifiers forKey:@"blockedBundleIdentifiers"];

    [self reloadSpecifiers];

}

- (void)deleteLog { // delete the log

    HBPreferences* logs = [[HBPreferences alloc] initWithIdentifier:@"love.litten.ve-logs"];
    NSMutableArray* storedLogs = [[logs objectForKey:@"loggedNotifications"] mutableCopy];

    for (int i = 0; i < [storedLogs count]; i++) {
        NSDictionary* log = [storedLogs objectAtIndex:i];
        if ([[log objectForKey:@"identifier"] intValue] == [self notificationID]) {
            // delete all attachments before deleting the log
            NSFileManager* fileManager = [NSFileManager defaultManager];
            for (NSString* attachment in [log objectForKey:@"attachments"])
                [fileManager removeItemAtPath:[NSString stringWithFormat:@"/var/mobile/Media/Vē/%@/%@", [log objectForKey:@"bundleID"], attachment] error:nil];
            
            [storedLogs removeObjectAtIndex:i];
            break;
        }
    }

    [logs setObject:storedLogs forKey:@"loggedNotifications"];

    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
