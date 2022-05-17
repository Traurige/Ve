#import "VeDetailAttachmentListController.h"

@implementation VeDetailAttachmentListController

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

- (NSArray *)specifiers { // add the specifiers

    _specifiers = [NSMutableArray new];


    // attachment
    [_specifiers addObject:[PSSpecifier groupSpecifierWithName:@"Attachment"]];

    PSSpecifier* attachmentSpecifier = [PSSpecifier preferenceSpecifierNamed:nil target:self set:nil get:nil detail:nil cell:PSStaticTextCell edit:nil];
    [attachmentSpecifier setProperty:[VeDetailFullAttachmentCell class] forKey:@"cellClass"];
    [attachmentSpecifier setProperty:[NSString stringWithFormat:@"%f", [UIImage imageWithData:[self attachmentData]].size.height / 2] forKey:@"height"];
    [attachmentSpecifier setProperty:[NSData dataWithData:[self attachmentData]] forKey:@"attachmentData"];
    [_specifiers addObject:attachmentSpecifier];


    // actions
    [_specifiers addObject:[PSSpecifier preferenceSpecifierNamed:@"Actions" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil]];

    PSSpecifier* copySpecifier = [PSSpecifier preferenceSpecifierNamed:@"Copy to Clipboard" target:self set:nil get:nil detail:nil cell:PSButtonCell edit:nil];
    [copySpecifier setButtonAction:@selector(copyAttachment)];
    [_specifiers addObject:copySpecifier];

    PSSpecifier* saveSpecifier = [PSSpecifier preferenceSpecifierNamed:@"Save to Photo Library" target:self set:nil get:nil detail:nil cell:PSButtonCell edit:nil];
    [saveSpecifier setButtonAction:@selector(saveAttachment)];
    [_specifiers addObject:saveSpecifier];


	return _specifiers;

}

- (BOOL)shouldReloadSpecifiersOnResume { // prevent the controller from reloading the view after inactivity

    return false;

}

- (void)copyAttachment { // copy the attachment

    [[UIPasteboard generalPasteboard] setImage:[UIImage imageWithData:[self attachmentData]]];

}

- (void)saveAttachment { // save the attachment

    UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:[self attachmentData]], nil, nil, nil);

}

@end