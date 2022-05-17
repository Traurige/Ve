#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <UIKit/UIKit.h>
#import "../Custom-Cells/VeDetailFullAttachmentCell.h"
#import "../PrivateHeaders.h"

@interface VeDetailAttachmentListController : PSListController
@property(atomic, assign)NSData* attachmentData;
@property(nonatomic, retain)_UIGrabber* grabber;
- (void)copyAttachment;
- (void)saveAttachment;
@end
