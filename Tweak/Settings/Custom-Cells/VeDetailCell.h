#import <UIKit/UIKit.h>
#import <Preferences/PSSpecifier.h>
#import "../PrivateHeaders.h"

@interface VeDetailCell : PSTableCell
@property(nonatomic, retain)UILabel* detailTitleLabel;
@property(nonatomic, retain)UILabel* detailContentLabel;
@end