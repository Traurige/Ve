#import <UIKit/UIKit.h>
#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "../Custom-Cells/VeStatisticsCell.h"
#import "../Custom-Cells/VeSearchBarCell.h"
#import "../Custom-Cells/VeNotificationCell.h"
#import "VePreferencesListController.h"
#import "VeDetailViewListController.h"
#import <Cephei/HBPreferences.h>

@interface VeLogsListController : PSListController <UISearchBarDelegate>
@property(nonatomic, retain)HBPreferences* preferences;
@property(nonatomic, retain)UIButton* settingsButton;
@property(nonatomic, retain)UIBarButtonItem* item;
@property(nonatomic, retain)UIRefreshControl* pullToRefreshControl;
@property(nonatomic, retain)NSArray* logs;
@property(nonatomic, retain)NSMutableArray* notificationSpecifiers;
- (void)createNotificationSpecifiersFromLogs:(NSArray *)logs withSearch:(NSString *)search;
- (void)openPreferences;
- (void)pullToRefresh;
- (void)expandStatistics;
- (void)expandLog:(PSSpecifier *)specifier;
@end
