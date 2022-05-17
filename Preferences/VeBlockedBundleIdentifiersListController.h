#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import "../Tweak/Settings/PrivateHeaders.h"
#import <Cephei/HBPreferences.h>

@interface VeBlockedBundleIdentifiersListController : PSEditableListController
@property(nonatomic, retain)HBPreferences* logsDictionary;
- (void)removedSpecifier:(PSSpecifier*)specifier;
@end
