#import "VeNotificationCell.h"

@implementation VeNotificationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier { // style the cell

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];


	// icon image view
	self.iconImageView = [UIImageView new];
	[[self iconImageView] setImage:[UIImage _applicationIconImageForBundleIdentifier:specifier.properties[@"bundleID"] format:1 scale:2]];
	[[self iconImageView] setContentMode:UIViewContentModeScaleAspectFit];
	[[self iconImageView] setClipsToBounds:YES];
	[[[self iconImageView] layer] setCornerRadius:7];
	[[[self iconImageView] layer] setBorderWidth:0.5];
	[[[self iconImageView] layer] setBorderColor:[[[UIColor labelColor] colorWithAlphaComponent:0.1] CGColor]];
	[self addSubview:[self iconImageView]];

	[[self iconImageView] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.iconImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:16],
		[self.iconImageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
		[self.iconImageView.heightAnchor constraintEqualToConstant:30],
		[self.iconImageView.widthAnchor constraintEqualToConstant:30]
    ]];


	// date label
	self.notificationDateLabel = [UILabel new];

	NSDateFormatter* dateFormat = [NSDateFormatter new];
	NSDate* date = specifier.properties[@"date"];
	NSCalendar* calendar = [NSCalendar currentCalendar];
	NSString* timeFormatValue = specifier.properties[@"timeFormat"];
	NSString* dateFormatValue = specifier.properties[@"dateFormat"];

	if ([calendar isDateInToday:date]) {
		[dateFormat setDateFormat:timeFormatValue];
		[[self notificationDateLabel] setText:[NSString stringWithFormat:@"Today, %@", [dateFormat stringFromDate:date]]];
	} else if ([calendar isDateInYesterday:date]) {
		[dateFormat setDateFormat:timeFormatValue];
		[[self notificationDateLabel] setText:[NSString stringWithFormat:@"Yesterday, %@", [dateFormat stringFromDate:date]]];
	} else {
		[dateFormat setDateFormat:[NSString stringWithFormat:@"%@, %@", dateFormatValue, timeFormatValue]];
		[[self notificationDateLabel] setText:[dateFormat stringFromDate:date]];
	}

	[[self notificationDateLabel] setTextColor:[[UIColor labelColor] colorWithAlphaComponent:0.6]];
	[[self notificationDateLabel] setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightRegular]];
	[[self notificationDateLabel] setTextAlignment:NSTextAlignmentRight];
	[self addSubview:[self notificationDateLabel]];

	[[self notificationDateLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.notificationDateLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:12],
        [self.notificationDateLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-16]
    ]];


	// title label
	self.notificationTitleLabel = [UILabel new];
	[[self notificationTitleLabel] setText:specifier.properties[@"title"]];
	[[self notificationTitleLabel] setTextColor:[UIColor labelColor]];
	[[self notificationTitleLabel] setFont:[UIFont systemFontOfSize:16 weight:UIFontWeightMedium]];
	[self addSubview:[self notificationTitleLabel]];

	[[self notificationTitleLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.notificationTitleLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:10],
        [self.notificationTitleLabel.leadingAnchor constraintEqualToAnchor:self.iconImageView.trailingAnchor constant:10],
		[self.notificationTitleLabel.trailingAnchor constraintEqualToAnchor:self.notificationDateLabel.leadingAnchor constant:-8]
    ]];


	// message label
	self.notificationMessageLabel = [UILabel new];
	[[self notificationMessageLabel] setText:specifier.properties[@"message"]];
	[[self notificationMessageLabel] setTextColor:[UIColor labelColor]];
	[[self notificationMessageLabel] setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular]];
	[self addSubview:[self notificationMessageLabel]];

	[[self notificationMessageLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.notificationMessageLabel.topAnchor constraintEqualToAnchor:self.notificationTitleLabel.bottomAnchor constant:2],
        [self.notificationMessageLabel.leadingAnchor constraintEqualToAnchor:self.iconImageView.trailingAnchor constant:10],
		[self.notificationMessageLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-16]
    ]];


	return self;

}

@end