#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <UIKit/UIKit.h>
#import "../Custom-Cells/VeDetailCell.h"
#import "../Custom-Cells/VeDetailAttachmentCell.h"
#import "VeDetailAttachmentListController.h"
#import "VeDetailMessageListController.h"
#import "../PrivateHeaders.h"
#import <objc/runtime.h>
#import <Cephei/HBPreferences.h>

@interface VeDetailViewListController : PSListController
@property(atomic, assign)NSUInteger notificationID;
@property(atomic, assign)NSString* notificationBundleID;
@property(atomic, assign)NSString* notificationDisplayName;
@property(atomic, assign)NSString* notificationTitle;
@property(atomic, assign)NSString* notificationMessage;
@property(atomic, assign)NSArray* notificationAttachments;
@property(atomic, assign)NSString* dateFormat;
@property(atomic, assign)NSString* timeFormat;
@property(atomic, assign)NSDate* notificationDate;
@property(nonatomic, retain)_UIGrabber* grabber;
- (void)copyContent:(PSSpecifier *)specifier;
- (void)expandMessage:(PSSpecifier *)specifier;
- (void)presentAttachment:(PSSpecifier *)specifier;
- (void)openApplication;
- (void)blockBundleIdentifier;
- (void)deleteLog;
@end
