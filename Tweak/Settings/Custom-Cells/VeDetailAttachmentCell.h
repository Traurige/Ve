#import <UIKit/UIKit.h>
#import <Preferences/PSSpecifier.h>

@interface VeDetailAttachmentCell : PSTableCell
@property(nonatomic, retain)UIImageView* attachmentImageView;
@property(nonatomic, retain)UIImageView* iconView;
@property(nonatomic, retain)UILabel* attachmentTitleLabel;
@property(nonatomic, retain)UILabel* attachmentSizeLabel;
@end