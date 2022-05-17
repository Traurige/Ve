#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <UIKit/UIKit.h>
#import "../PrivateHeaders.h"

@interface VeDetailMessageListController : PSListController
@property(atomic, assign)NSString* message;
@property(nonatomic, retain)_UIGrabber* grabber;
- (void)copyMessage;
@end
