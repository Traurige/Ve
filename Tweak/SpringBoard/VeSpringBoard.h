#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>

HBPreferences* preferences = nil;
BOOL enabled = NO;

// logs
BOOL logMessagesWithoutContentSwitch = NO;

// attachments
BOOL saveAttachmentsSwitch = YES;

// household
NSUInteger entryLimitValue = 1;
BOOL deleteLogsAutomaticallySwitch = YES;
NSUInteger deleteLogsAutomaticallyAfterDaysValue = 31;

@interface BBAttachmentMetadata : NSObject
@property(nonatomic, copy, readonly)NSURL* URL;
@end

@interface BBAction : NSObject
@property(nonatomic, copy)NSURL* launchURL;
@end

@interface BBBulletin : NSObject
@property(nonatomic, copy)NSString* sectionID;
@property(nonatomic, copy)NSString* title;
@property(nonatomic, copy)NSString* message;
@property(nonatomic, retain)NSDate* date;
@property(nonatomic, copy)BBAttachmentMetadata* primaryAttachment;
@property(nonatomic, copy)BBAction* defaultAction;
@property(nonatomic, retain)NSMutableDictionary* actions;
@end

@interface SBApplication : NSObject
@property(nonatomic, readonly)NSString* displayName;
@end

@interface SBApplicationController : NSObject
+ (id)sharedInstance;
- (id)applicationWithBundleIdentifier:(id)arg1;
@end
