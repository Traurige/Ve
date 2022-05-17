#import <UIKit/UIKit.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListController.h>
#import "Controllers/VeLogsListController.h"
#import <Cephei/HBPreferences.h>

HBPreferences* preferences = nil;
BOOL enabled = NO;

@interface PSUIPrefsListController : UIViewController
@end

@interface BulletinBoardController : PSListController
@end