#import "VeSettings.h"

%group VePreferences

%hook BulletinBoardController

- (void)viewDidLoad { // add ve's specifiers to the notification controller

	%orig;

	// ve group cell
	PSSpecifier* veGroupSpecifier = [PSSpecifier emptyGroupSpecifier];
	[veGroupSpecifier setProperty:@"Lists all Notifications that have been logged by Vē in the past." forKey:@"footerText"];

	// ve cell
	PSSpecifier* veButtonSpecifier = [PSSpecifier preferenceSpecifierNamed:@"List all Notification Logs" target:self set:nil get:nil detail:[VeLogsListController class] cell:PSLinkCell edit:nil];
	[veButtonSpecifier setProperty:@(YES) forKey:@"enabled"];

	[self insertContiguousSpecifiers:@[veGroupSpecifier, veButtonSpecifier] atIndex:0];

}

- (BOOL)shouldReloadSpecifiersOnResume { // prevent the controller from reloading the view after inactivity

    return false;

}

%end

%end

%group VeBundleLoader

%hook PSUIPrefsListController

- (void)lazyLoadBundle:(PSSpecifier *)specifier { // initialize the actual hook after everything else has loaded

	%orig;

	if ([[specifier identifier] isEqualToString:@"NOTIFICATIONS_ID"]) {
		%init(VePreferences);
		MSHookMessageEx([self class], _cmd, (IMP)&%orig, NULL); // deactivate this hook (PSUIPrefsListController)
  	}

}

%end

%end

%ctor {

	preferences = [[HBPreferences alloc] initWithIdentifier:@"love.litten.vepreferences"];

	[preferences registerBool:&enabled default:NO forKey:@"Enabled"];
	if (!enabled) return;

	%init(VeBundleLoader);

}