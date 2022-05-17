#import "VeDetailMessageListController.h"

@implementation VeDetailMessageListController

- (void)viewDidLoad {
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

- (NSArray *)specifiers {
    _specifiers = [NSMutableArray new];

    // message
    PSSpecifier* messageSpecifier = [PSSpecifier preferenceSpecifierNamed:@"Message" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
	[messageSpecifier setProperty:[self message] forKey:@"footerText"];
    [_specifiers addObject:messageSpecifier];

    // actions
    [_specifiers addObject:[PSSpecifier preferenceSpecifierNamed:@"Actions" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil]];

    PSSpecifier* copySpecifier = [PSSpecifier preferenceSpecifierNamed:@"Copy to Clipboard" target:self set:nil get:nil detail:nil cell:PSButtonCell edit:nil];
    [copySpecifier setButtonAction:@selector(copyMessage)];
    [_specifiers addObject:copySpecifier];

	return _specifiers;
}

- (BOOL)shouldReloadSpecifiersOnResume {
    return false;
}

- (void)copyMessage {
    [[UIPasteboard generalPasteboard] setString:[self message]];
}

@end
