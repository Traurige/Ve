#import "VeStatisticsCell.h"

@implementation VeStatisticsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier { // style the cell

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];


	// separator
	self.separatorView = [UIView new];
	[[self separatorView] setBackgroundColor:[[UIColor labelColor] colorWithAlphaComponent:0.1]];
	[self addSubview:[self separatorView]];

	[[self separatorView] setTranslatesAutoresizingMaskIntoConstraints:NO];
	[NSLayoutConstraint activateConstraints:@[
		[self.separatorView.topAnchor constraintEqualToAnchor:self.topAnchor],
		[self.separatorView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
		[self.separatorView.heightAnchor constraintEqualToConstant:75],
		[self.separatorView.widthAnchor constraintEqualToConstant:1]
	]];


	// today
	// title label
	self.todayTitleLabel = [UILabel new];
	[[self todayTitleLabel] setText:@"Total of today"];
	[[self todayTitleLabel] setTextColor:[[UIColor labelColor] colorWithAlphaComponent:0.6]];
	[[self todayTitleLabel] setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightRegular]];
	[self addSubview:[self todayTitleLabel]];

	[[self todayTitleLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
	[NSLayoutConstraint activateConstraints:@[
		[self.todayTitleLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:12],
		[self.todayTitleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:12],
		[self.todayTitleLabel.trailingAnchor constraintEqualToAnchor:self.separatorView.leadingAnchor]
	]];


	// value label
	self.todayValueLabel = [UILabel new];
	if ([specifier.properties[@"todayValue"] isEqualToString:@"1"]) [[self todayValueLabel] setText:[specifier.properties[@"todayValue"] stringByAppendingString:@" Log"]];
	else [[self todayValueLabel] setText:[specifier.properties[@"todayValue"] stringByAppendingString:@" Logs"]];
	[[self todayValueLabel] setTextColor:[UIColor labelColor]];
	[[self todayValueLabel] setFont:[UIFont systemFontOfSize:34 weight:UIFontWeightRegular]];
	[self addSubview:[self todayValueLabel]];

	[[self todayValueLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
	[NSLayoutConstraint activateConstraints:@[
		[self.todayValueLabel.topAnchor constraintEqualToAnchor:self.todayTitleLabel.bottomAnchor],
		[self.todayValueLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:12],
		[self.todayValueLabel.trailingAnchor constraintEqualToAnchor:self.separatorView.leadingAnchor]
	]];


	// past seven days
	// title label
	self.pastSevenDaysTitleLabel = [UILabel new];
	[[self pastSevenDaysTitleLabel] setText:@"Past seven days"];
	[[self pastSevenDaysTitleLabel] setTextColor:[[UIColor labelColor] colorWithAlphaComponent:0.6]];
	[[self pastSevenDaysTitleLabel] setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightRegular]];
	[self addSubview:[self pastSevenDaysTitleLabel]];

	[[self pastSevenDaysTitleLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
	[NSLayoutConstraint activateConstraints:@[
		[self.pastSevenDaysTitleLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:12],
		[self.pastSevenDaysTitleLabel.leadingAnchor constraintEqualToAnchor:self.separatorView.trailingAnchor constant:12],
		[self.pastSevenDaysTitleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-12]
	]];

	// value label
	self.pastSevenDaysValueLabel = [UILabel new];
	if ([specifier.properties[@"pastSevenDaysValue"] isEqualToString:@"1"]) [[self pastSevenDaysValueLabel] setText:[specifier.properties[@"pastSevenDaysValue"] stringByAppendingString:@" Log"]];
	else [[self pastSevenDaysValueLabel] setText:[specifier.properties[@"pastSevenDaysValue"] stringByAppendingString:@" Logs"]];
	[[self pastSevenDaysValueLabel] setTextColor:[UIColor labelColor]];
	[[self pastSevenDaysValueLabel] setFont:[UIFont systemFontOfSize:34 weight:UIFontWeightRegular]];
	[self addSubview:[self pastSevenDaysValueLabel]];

	[[self pastSevenDaysValueLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
	[NSLayoutConstraint activateConstraints:@[
		[self.pastSevenDaysValueLabel.topAnchor constraintEqualToAnchor:self.pastSevenDaysTitleLabel.bottomAnchor],
		[self.pastSevenDaysValueLabel.leadingAnchor constraintEqualToAnchor:self.separatorView.trailingAnchor constant:12],
		[self.pastSevenDaysValueLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-12]
	]];


	return self;

}

@end
