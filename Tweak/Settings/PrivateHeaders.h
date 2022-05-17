#import <UIKit/UIKit.h>
#import <Preferences/PSListController.h>

@interface UIImage (Ve)
+ (id)_applicationIconImageForBundleIdentifier:(id)arg1 format:(int)arg2 scale:(double)arg3;
@end

@interface _UIGrabber : UIControl
@end

@interface PSEditableListController : PSListController
@end

@interface PSSpecifier (Ve)
+ (id)emptyGroupSpecifier;
+ (id)deleteButtonSpecifierWithName:(id)arg1 target:(id)arg2 action:(SEL)arg3;
- (void)setValues:(id)arg1 titles:(id)arg2;
- (void)setButtonAction:(SEL)arg1;
@end

@interface UISearchBar (Ve)
- (void)_setEnabled:(BOOL)arg1;
@end

@interface UILabel (Ve)
- (void)setMarqueeEnabled:(BOOL)arg1;
- (void)setMarqueeRunning:(BOOL)arg1;
@end

@interface LSApplicationWorkspace : NSObject
+ (id)defaultWorkspace;
- (BOOL)openApplicationWithBundleID:(id)arg1;
@end