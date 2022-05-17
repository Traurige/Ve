#import <UIKit/UIKit.h>
#import <Preferences/PSSpecifier.h>
#import "../PrivateHeaders.h"

@interface VeNotificationCell : PSTableCell
@property(nonatomic, retain)UIImageView* iconImageView;
@property(nonatomic, retain)UILabel* notificationTitleLabel;
@property(nonatomic, retain)UILabel* notificationMessageLabel;
@property(nonatomic, retain)UILabel* notificationDateLabel;
@end