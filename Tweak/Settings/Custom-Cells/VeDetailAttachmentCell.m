#import "VeDetailAttachmentCell.h"

@implementation VeDetailAttachmentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier { // style the cell

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];


	// attachment
	UIImage* attachment = [UIImage imageWithData:[NSData dataWithData:specifier.properties[@"attachmentData"]]];
	NSString* attachmentSize = [NSString stringWithFormat:@"Width: %.0fpx Height: %.0fpx", attachment.size.width, attachment.size.height];
	NSString* attachmentIndex = [NSString stringWithFormat:@"Attachment %@", specifier.properties[@"attachmentIndex"]];


	// image view
	self.attachmentImageView = [UIImageView new];
	[[self attachmentImageView] setImage:attachment];
	[[self attachmentImageView] setContentMode:UIViewContentModeScaleAspectFill];
	[[self attachmentImageView] setClipsToBounds:YES];
	[[[self attachmentImageView] layer] setCornerRadius:6];
	[self addSubview:[self attachmentImageView]];

	[[self attachmentImageView] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.attachmentImageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:8],
		[self.attachmentImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:8],
		[self.attachmentImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-8],
		[self.attachmentImageView.widthAnchor constraintEqualToConstant:70]
    ]];


	// icon view
	self.iconView = [UIImageView new];
	[[self iconView] setImage:[UIImage systemImageNamed:@"photo"]];
	[[self iconView] setContentMode:UIViewContentModeScaleAspectFit];
	[[self iconView] setTintColor:[UIColor labelColor]];
	[[self iconView] setAlpha:0.4];
	[self addSubview:[self iconView]];

	[[self iconView] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.iconView.topAnchor constraintEqualToAnchor:self.topAnchor constant:8],
		[self.iconView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-8],
		[self.iconView.widthAnchor constraintEqualToConstant:15],
		[self.iconView.heightAnchor constraintEqualToConstant:15]
    ]];


	// title label
	self.attachmentTitleLabel = [UILabel new];
	[[self attachmentTitleLabel] setText:attachmentIndex];
	[[self attachmentTitleLabel] setTextColor:[UIColor labelColor]];
	[[self attachmentTitleLabel] setFont:[UIFont systemFontOfSize:16 weight:UIFontWeightMedium]];
	[self addSubview:[self attachmentTitleLabel]];

	[[self attachmentTitleLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.attachmentTitleLabel.leadingAnchor constraintEqualToAnchor:self.attachmentImageView.trailingAnchor constant:12],
		[self.attachmentTitleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-16],
		[self.attachmentTitleLabel.centerYAnchor constraintEqualToAnchor:self.attachmentImageView.centerYAnchor constant:-10]
    ]];


	// size label
	self.attachmentSizeLabel = [UILabel new];
	[[self attachmentSizeLabel] setText:attachmentSize];
	[[self attachmentSizeLabel] setTextColor:[[UIColor labelColor] colorWithAlphaComponent:0.6]];
	[[self attachmentSizeLabel] setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular]];
	[self addSubview:[self attachmentSizeLabel]];

	[[self attachmentSizeLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
		[self.attachmentSizeLabel.leadingAnchor constraintEqualToAnchor:self.attachmentImageView.trailingAnchor constant:12],
		[self.attachmentSizeLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-16],
		[self.attachmentSizeLabel.centerYAnchor constraintEqualToAnchor:self.attachmentImageView.centerYAnchor constant:10]
    ]];


	return self;

}

@end