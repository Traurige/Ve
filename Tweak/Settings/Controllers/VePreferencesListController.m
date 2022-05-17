#import "VePreferencesListController.h"

@implementation VePreferencesListController

- (void)viewDidLoad { // add the settings

    [super viewDidLoad];

    [self setTitle:@"Preferences"];


    // load the preference bundle
    NSBundle* preferenceBundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/VePreferences.bundle"];
    [preferenceBundle load];

    // add the preference bundle as a subview
    self.preferencesRootViewController = [[UINavigationController alloc] initWithRootViewController:[[preferenceBundle principalClass] new]];
    UIView* preferencesView = [[self preferencesRootViewController] view];
    [preferencesView setFrame:[[self view] bounds]];
    [[self view] addSubview:preferencesView];

}

- (BOOL)shouldReloadSpecifiersOnResume { // prevent the controller from reloading the view after inactivity

    return false;

}

@end
