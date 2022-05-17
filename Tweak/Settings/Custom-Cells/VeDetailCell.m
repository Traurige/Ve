#import "VeDetailCell.h"

@implementation VeDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier { // style the cell

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];


	// content label
	self.detailContentLabel = [UILabel new];
	[[self detailContentLabel] setText:specifier.properties[@"content"]];
	[[self detailContentLabel] setTextColor:[[UIColor labelColor] colorWithAlphaComponent:0.6]];
	[[self detailContentLabel] setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightRegular]];
	[[self detailContentLabel] setTextAlignment:NSTextAlignmentRight];
	[[self detailContentLabel] setMarqueeEnabled:YES];
	[[self detailContentLabel] setMarqueeRunning:YES];
	[self addSubview:[self detailContentLabel]];

	[[self detailContentLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.detailContentLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-16],
		[self.detailContentLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
    ]];


	// title label
	self.detailTitleLabel = [UILabel new];
	[[self detailTitleLabel] setText:specifier.properties[@"title"]];
	[[self detailTitleLabel] setTextColor:[UIColor labelColor]];
	[[self detailTitleLabel] setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium]];
	[self addSubview:[self detailTitleLabel]];

	[[self detailTitleLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.detailTitleLabel.trailingAnchor constraintEqualToAnchor:self.detailContentLabel.leadingAnchor constant:-8],
		[self.detailTitleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:16],
		[self.detailTitleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
    ]];


	return self;

}

@end