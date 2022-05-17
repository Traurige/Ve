#import <UIKit/UIKit.h>
#import <Preferences/PSSpecifier.h>

@interface VeStatisticsCell : PSTableCell
@property(nonatomic, retain)UILabel* todayTitleLabel;
@property(nonatomic, retain)UILabel* todayValueLabel;
@property(nonatomic, retain)UIView* separatorView;
@property(nonatomic, retain)UILabel* pastSevenDaysTitleLabel;
@property(nonatomic, retain)UILabel* pastSevenDaysValueLabel;
@end
