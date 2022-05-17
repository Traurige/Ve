#import "VeBlockedBundleIdentifiersListController.h"

@implementation VeBlockedBundleIdentifiersListController

- (void)viewDidLoad { // set the title and initialize the plus button

    [super viewDidLoad];

    [self setTitle:@"Blocked Bundle Identifiers"];

}

- (NSArray *)specifiers {  // list all options

    _specifiers = [NSMutableArray new];

    self.logsDictionary = [[HBPreferences alloc] initWithIdentifier:@"love.litten.ve-logs"];
    NSArray* blockedBundleIdentifiers = [[self logsDictionary] objectForKey:@"blockedBundleIdentifiers"];


    // if there's no blocked bundle identifiers return here
    if ([blockedBundleIdentifiers count] == 0) {
        PSSpecifier* emptyListSpecifier = [PSSpecifier emptyGroupSpecifier];
        [emptyListSpecifier setProperty:@"Vē will not log any notifications sent with blocked bundle identifiers." forKey:@"footerText"];
        [emptyListSpecifier setProperty:@(1) forKey:@"footerAlignment"];
        [_specifiers addObject:emptyListSpecifier];

        return _specifiers;
    }


    // list all blocked bundle identifiers
    [_specifiers addObject:[PSSpecifier groupSpecifierWithName:@"Bundle Identifiers"]];

    for (NSString* bundleIdentifier in blockedBundleIdentifiers) {
        PSSpecifier* bundleIdentifierSpecifier = [PSSpecifier preferenceSpecifierNamed:bundleIdentifier target:self set:nil get:nil detail:nil cell:PSTitleValueCell edit:nil];
        [bundleIdentifierSpecifier setProperty:NSStringFromSelector(@selector(removedSpecifier:)) forKey:PSDeletionActionKey];
        [bundleIdentifierSpecifier setProperty:bundleIdentifier forKey:@"bundleIdentifier"];
        [_specifiers addObject:bundleIdentifierSpecifier];
    }


	return _specifiers;

}

- (BOOL)shouldReloadSpecifiersOnResume { // prevent the controller from reloading the view after inactivity

    return false;

}

- (void)removedSpecifier:(PSSpecifier*)specifier { // remove the selected bundle identifier

    NSMutableArray* blockedBundleIdentifiers = [[[self logsDictionary] objectForKey:@"blockedBundleIdentifiers"] mutableCopy];
    [blockedBundleIdentifiers removeObject:specifier.properties[@"bundleIdentifier"]];
    [[self logsDictionary] setObject:blockedBundleIdentifiers forKey:@"blockedBundleIdentifiers"];

    [self reloadSpecifiers];

}

@end
