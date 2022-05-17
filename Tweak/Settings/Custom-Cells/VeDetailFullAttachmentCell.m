#import "VeDetailFullAttachmentCell.h"

@implementation VeDetailFullAttachmentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier { // style the cell

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];


	// image view
	self.attachmentImageView = [UIImageView new];
	[[self attachmentImageView] setImage:[UIImage imageWithData:specifier.properties[@"attachmentData"]]];
	[[self attachmentImageView] setContentMode:UIViewContentModeScaleAspectFill];
	[self addSubview:[self attachmentImageView]];

	[[self attachmentImageView] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.attachmentImageView.topAnchor constraintEqualToAnchor:self.topAnchor],
		[self.attachmentImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
		[self.attachmentImageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
		[self.attachmentImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
    ]];


	return self;

}

@end