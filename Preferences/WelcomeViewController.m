#import "WelcomeViewController.h"

@implementation WelcomeViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    [[self view] setBackgroundColor:[UIColor systemBackgroundColor]];

    NSData* inData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:@"/Library/PreferenceBundles/VePreferences.bundle/welcome/Circle Of Love.ttf"]];
    CFErrorRef error;
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)inData);
    CGFontRef font = CGFontCreateWithDataProvider(provider);
    if (!CTFontManagerRegisterGraphicsFont(font, &error)) {
        CFStringRef errorDescription = CFErrorCopyDescription(error);
        CFRelease(errorDescription);
    }
    CFRelease(font);
    CFRelease(provider);


    // header
    self.headerImageView = [UIImageView new];
    [[self headerImageView] setContentMode:UIViewContentModeScaleAspectFill];
    [[self headerImageView] setImage:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/VePreferences.bundle/welcome/header.png"]];
    [[self view] addSubview:[self headerImageView]];

    [[self headerImageView] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.headerImageView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:12],
        [self.headerImageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.headerImageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.headerImageView.heightAnchor constraintEqualToConstant:400],
    ]];
    
    
    // drag view
    self.dragView = [UIView new];
    [[self dragView] setBackgroundColor:[UIColor systemBackgroundColor]];
    [[[self dragView] layer] setBorderWidth:3];
    [[[self dragView] layer] setBorderColor:[[UIColor colorWithRed:1 green:0.47 blue:0.60 alpha:1] CGColor]];
    [[self view] addSubview:[self dragView]];
    
    [[self dragView] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.dragView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.dragView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:-3],
        [self.dragView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:3],
        [self.dragView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:3],
    ]];
    [[self dragView] setTransform:CGAffineTransformMakeTranslation(0, 330)];
    
    
    // pan gesture
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [[self dragView] addGestureRecognizer:[self panGesture]];
    
    
    // header title
    self.headerTitle = [UILabel new];
    [[self headerTitle] setText:@"Wondercafe"];
    [[self headerTitle] setFont:[UIFont fontWithName:@"Circle Of Love" size:50]];
    [[self headerTitle] setTextColor:[UIColor labelColor]];
    [[self dragView] addSubview:[self headerTitle]];
    
    [[self headerTitle] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.headerTitle.topAnchor constraintEqualToAnchor:self.dragView.topAnchor constant:12],
        [self.headerTitle.centerXAnchor constraintEqualToAnchor:self.dragView.centerXAnchor],
    ]];
    
    
    // header subtitle
    self.headerSubtitle = [UILabel new];
    [[self headerSubtitle] setText:@"merci beaucoup"];
    [[self headerSubtitle] setFont:[UIFont fontWithName:@"Circle Of Love" size:27]];
    [[self headerSubtitle] setTextColor:[UIColor labelColor]];
    [[self dragView] addSubview:[self headerSubtitle]];
    
    [[self headerSubtitle] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.headerSubtitle.topAnchor constraintEqualToAnchor:self.headerTitle.bottomAnchor constant:0],
        [self.headerSubtitle.centerXAnchor constraintEqualToAnchor:self.dragView.centerXAnchor],
    ]];
    
    
    // twitter cell
    // icon
    self.twitterCellIcon = [UIButton new];
    [[self twitterCellIcon] addTarget:self action:@selector(openTwitterURL) forControlEvents:UIControlEventTouchUpInside];
    [[self twitterCellIcon] setContentMode:UIViewContentModeScaleAspectFill];
    [[self twitterCellIcon] setImage:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/VePreferences.bundle/welcome/twitter.png"] forState:UIControlStateNormal];
    [[self twitterCellIcon] setClipsToBounds:YES];
    [[[self twitterCellIcon] layer] setCornerRadius:10];
    [[[self twitterCellIcon] layer] setBorderColor:[[UIColor colorWithRed:0.93 green:0.76 blue:1 alpha:1] CGColor]];
    [[[self twitterCellIcon] layer] setBorderWidth:2];
    [[self dragView] addSubview:[self twitterCellIcon]];

    [[self twitterCellIcon] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.twitterCellIcon.topAnchor constraintEqualToAnchor:self.headerTitle.bottomAnchor constant:56],
        [self.twitterCellIcon.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:16],
        [self.twitterCellIcon.widthAnchor constraintEqualToConstant:85],
        [self.twitterCellIcon.heightAnchor constraintEqualToConstant:85],
    ]];
    
    
    // title
    self.twitterCellTitle = [UILabel new];
    [[self twitterCellTitle] setText:@"Twitter"];
    [[self twitterCellTitle] setFont:[UIFont systemFontOfSize:27 weight:UIFontWeightMedium]];
    [[self twitterCellTitle] setTextColor:[UIColor labelColor]];
    [[self dragView] addSubview:[self twitterCellTitle]];
    
    [[self twitterCellTitle] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.twitterCellTitle.topAnchor constraintEqualToAnchor:self.twitterCellIcon.topAnchor constant:4],
        [self.twitterCellTitle.leadingAnchor constraintEqualToAnchor:self.twitterCellIcon.trailingAnchor constant:16],
        [self.twitterCellTitle.trailingAnchor constraintEqualToAnchor:self.dragView.trailingAnchor constant:-16],
    ]];
    
    
    // subtitle
    self.twitterCellSubtitle = [UILabel new];
    [[self twitterCellSubtitle] setText:@"Watch me turn iOS upside down"];
    [[self twitterCellSubtitle] setNumberOfLines:2];
    [[self twitterCellSubtitle] setFont:[UIFont systemFontOfSize:18 weight:UIFontWeightRegular]];
    [[self twitterCellSubtitle] setTextColor:[UIColor labelColor]];
    [[self dragView] addSubview:[self twitterCellSubtitle]];
    
    [[self twitterCellSubtitle] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.twitterCellSubtitle.topAnchor constraintEqualToAnchor:self.twitterCellTitle.bottomAnchor constant:0],
        [self.twitterCellSubtitle.leadingAnchor constraintEqualToAnchor:self.twitterCellIcon.trailingAnchor constant:16],
        [self.twitterCellSubtitle.trailingAnchor constraintEqualToAnchor:self.dragView.trailingAnchor constant:-16],
    ]];
    
    
    // github cell
    // icon
    self.githubCellIcon = [UIButton new];
    [[self githubCellIcon] addTarget:self action:@selector(openGitHubURL) forControlEvents:UIControlEventTouchUpInside];
    [[self githubCellIcon] setContentMode:UIViewContentModeScaleAspectFill];
    [[self githubCellIcon] setImage:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/VePreferences.bundle/welcome/github.png"] forState:UIControlStateNormal];
    [[self githubCellIcon] setClipsToBounds:YES];
    [[[self githubCellIcon] layer] setCornerRadius:10];
    [[[self githubCellIcon] layer] setBorderColor:[[UIColor colorWithRed:0.84 green:0.89 blue:1 alpha:1] CGColor]];
    [[[self githubCellIcon] layer] setBorderWidth:2];
    [[self dragView] addSubview:[self githubCellIcon]];

    [[self githubCellIcon] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.githubCellIcon.topAnchor constraintEqualToAnchor:self.twitterCellIcon.bottomAnchor constant:45],
        [self.githubCellIcon.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:16],
        [self.githubCellIcon.widthAnchor constraintEqualToConstant:85],
        [self.githubCellIcon.heightAnchor constraintEqualToConstant:85],
    ]];
    
    
    // title
    self.githubCellTitle = [UILabel new];
    [[self githubCellTitle] setText:@"GitHub"];
    [[self githubCellTitle] setFont:[UIFont systemFontOfSize:27 weight:UIFontWeightMedium]];
    [[self githubCellTitle] setTextColor:[UIColor labelColor]];
    [[self dragView] addSubview:[self githubCellTitle]];
    
    [[self githubCellTitle] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.githubCellTitle.topAnchor constraintEqualToAnchor:self.githubCellIcon.topAnchor constant:4],
        [self.githubCellTitle.leadingAnchor constraintEqualToAnchor:self.githubCellIcon.trailingAnchor constant:16],
        [self.githubCellTitle.trailingAnchor constraintEqualToAnchor:self.dragView.trailingAnchor constant:-16],
    ]];
    
    
    // subtitle
    self.githubCellSubtitle = [UILabel new];
    [[self githubCellSubtitle] setText:@"See how my tweaks work on my GitHub"];
    [[self githubCellSubtitle] setNumberOfLines:2];
    [[self githubCellSubtitle] setFont:[UIFont systemFontOfSize:18 weight:UIFontWeightRegular]];
    [[self githubCellSubtitle] setTextColor:[UIColor labelColor]];
    [[self dragView] addSubview:[self githubCellSubtitle]];
    
    [[self githubCellSubtitle] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.githubCellSubtitle.topAnchor constraintEqualToAnchor:self.githubCellTitle.bottomAnchor constant:0],
        [self.githubCellSubtitle.leadingAnchor constraintEqualToAnchor:self.githubCellIcon.trailingAnchor constant:16],
        [self.githubCellSubtitle.trailingAnchor constraintEqualToAnchor:self.dragView.trailingAnchor constant:-16],
    ]];
    
    
    // discord cell
    // icon
    self.discordCellIcon = [UIButton new];
    [[self discordCellIcon] addTarget:self action:@selector(openDiscordURL) forControlEvents:UIControlEventTouchUpInside];
    [[self discordCellIcon] setContentMode:UIViewContentModeScaleAspectFill];
    [[self discordCellIcon] setImage:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/VePreferences.bundle/welcome/discord.png"] forState:UIControlStateNormal];
    [[self discordCellIcon] setClipsToBounds:YES];
    [[[self discordCellIcon] layer] setCornerRadius:10];
    [[[self discordCellIcon] layer] setBorderColor:[[UIColor colorWithRed:0.58 green:0.66 blue:0.71 alpha:1] CGColor]];
    [[[self discordCellIcon] layer] setBorderWidth:2];
    [[self dragView] addSubview:[self discordCellIcon]];

    [[self discordCellIcon] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.discordCellIcon.topAnchor constraintEqualToAnchor:self.githubCellIcon.bottomAnchor constant:45],
        [self.discordCellIcon.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:16],
        [self.discordCellIcon.widthAnchor constraintEqualToConstant:85],
        [self.discordCellIcon.heightAnchor constraintEqualToConstant:85],
    ]];
    
    
    // title
    self.discordCellTitle = [UILabel new];
    [[self discordCellTitle] setText:@"litcord"];
    [[self discordCellTitle] setFont:[UIFont systemFontOfSize:27 weight:UIFontWeightMedium]];
    [[self discordCellTitle] setTextColor:[UIColor labelColor]];
    [[self dragView] addSubview:[self discordCellTitle]];
    
    [[self discordCellTitle] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.discordCellTitle.topAnchor constraintEqualToAnchor:self.discordCellIcon.topAnchor constant:4],
        [self.discordCellTitle.leadingAnchor constraintEqualToAnchor:self.discordCellIcon.trailingAnchor constant:16],
        [self.discordCellTitle.trailingAnchor constraintEqualToAnchor:self.dragView.trailingAnchor constant:-16],
    ]];
    
    
    // subtitle
    self.discordCellSubtitle = [UILabel new];
    [[self discordCellSubtitle] setText:@"The most wholesome and calm discord for jailbreakers"];
    [[self discordCellSubtitle] setNumberOfLines:2];
    [[self discordCellSubtitle] setFont:[UIFont systemFontOfSize:18 weight:UIFontWeightRegular]];
    [[self discordCellSubtitle] setTextColor:[UIColor labelColor]];
    [[self dragView] addSubview:[self discordCellSubtitle]];
    
    [[self discordCellSubtitle] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.discordCellSubtitle.topAnchor constraintEqualToAnchor:self.discordCellTitle.bottomAnchor constant:0],
        [self.discordCellSubtitle.leadingAnchor constraintEqualToAnchor:self.discordCellIcon.trailingAnchor constant:16],
        [self.discordCellSubtitle.trailingAnchor constraintEqualToAnchor:self.dragView.trailingAnchor constant:-16],
    ]];
    
    
    // hint label
    self.hintLabel = [UILabel new];
    [[self hintLabel] setText:@"You can always access\n these links inside the preferences"];
    [[self hintLabel] setNumberOfLines:2];
    [[self hintLabel] setTextAlignment:NSTextAlignmentCenter];
    [[self hintLabel] setFont:[UIFont systemFontOfSize:16 weight:UIFontWeightMedium]];
    [[self hintLabel] setTextColor:[UIColor labelColor]];
    [[self dragView] addSubview:[self hintLabel]];

    [[self hintLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.hintLabel.bottomAnchor constraintEqualToAnchor:self.dragView.bottomAnchor constant:-32],
        [self.hintLabel.leadingAnchor constraintEqualToAnchor:self.dragView.leadingAnchor constant:32],
        [self.hintLabel.trailingAnchor constraintEqualToAnchor:self.dragView.trailingAnchor constant:-32],
    ]];

}

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer {

    CGPoint translation = CGPointMake(0, 0);
    
    if ([recognizer state] == UIGestureRecognizerStateChanged) {
        translation = [recognizer translationInView:[self dragView]];
        if (translation.y > 0) return;
        [UIView animateWithDuration:0.1 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [[self dragView] setTransform:CGAffineTransformMakeTranslation(0, 330 + translation.y)];
        } completion:nil];
        
        if (translation.y <= -150) {
            [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [[self dragView] setTransform:CGAffineTransformIdentity];
                [[[self dragView] layer] setBorderWidth:0];
                [[self headerSubtitle] setAlpha:0];
            } completion:nil];
            [[self panGesture] setEnabled:NO];
        }
    } else if ([recognizer state] == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [[self dragView] setTransform:CGAffineTransformMakeTranslation(0, 330)];
        } completion:nil];
    }

}

- (void)openTwitterURL {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/schneelittchen"] options:@{} completionHandler:nil];
    
}

- (void)openGitHubURL {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/schneelittchen"] options:@{} completionHandler:nil];
    
}

- (void)openDiscordURL {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://discord.gg/fPHN8KG"] options:@{} completionHandler:nil];
    
}

@end