#import "VeExcludedPhrasesListController.h"

@implementation VeExcludedPhrasesListController

- (void)viewDidLoad { // set the title and initialize the plus button

    [super viewDidLoad];

    [self setTitle:@"Excluded Phrases"];

}

- (NSArray *)specifiers {  // list all options

    _specifiers = [NSMutableArray new];

    self.logsDictionary = [[HBPreferences alloc] initWithIdentifier:@"love.litten.ve-logs"];
    NSArray* excludedPhrases = [[self logsDictionary] objectForKey:@"excludedPhrases"];


    // if there's no exlusions return here
    if ([excludedPhrases count] == 0) {
        PSSpecifier* emptyListSpecifier = [PSSpecifier emptyGroupSpecifier];
        [emptyListSpecifier setProperty:@"Vē will not log any notifications that include excluded phrases." forKey:@"footerText"];
        [emptyListSpecifier setProperty:@(1) forKey:@"footerAlignment"];
        [_specifiers addObject:emptyListSpecifier];

        return _specifiers;
    }


    // list all excluded phrases
    [_specifiers addObject:[PSSpecifier groupSpecifierWithName:@"Excluded Phrases"]];

    for (NSString* excludedPhrase in excludedPhrases) {
        PSSpecifier* excludedPhraseSpecifier = [PSSpecifier preferenceSpecifierNamed:excludedPhrase target:self set:nil get:nil detail:nil cell:PSTitleValueCell edit:nil];
        [excludedPhraseSpecifier setProperty:NSStringFromSelector(@selector(removedSpecifier:)) forKey:PSDeletionActionKey];
        [excludedPhraseSpecifier setProperty:excludedPhrase forKey:@"excludedPhrase"];
        [_specifiers addObject:excludedPhraseSpecifier];
    }


	return _specifiers;

}

- (BOOL)shouldReloadSpecifiersOnResume { // prevent the controller from reloading the view after inactivity

    return false;

}

- (void)removedSpecifier:(PSSpecifier*)specifier { // remove the selected phrase

    NSMutableArray* excludedPhrases = [[[self logsDictionary] objectForKey:@"excludedPhrases"] mutableCopy];
    [excludedPhrases removeObject:specifier.properties[@"excludedPhrase"]];
    [[self logsDictionary] setObject:excludedPhrases forKey:@"excludedPhrases"];

    [self reloadSpecifiers];

}

@end
