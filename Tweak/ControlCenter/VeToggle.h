#import <UIKit/UIKit.h>
#import <ControlCenterUIKit/CCUIToggleModule.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import <Cephei/HBPreferences.h>

@interface VeToggle : CCUIToggleModule
@property(nonatomic, retain)HBPreferences* preferences;
@end
