#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface WelcomeViewController : UIViewController
@property(nonatomic, retain)UIImageView* headerImageView;
@property(nonatomic, retain)UIView* dragView;
@property(nonatomic, retain)UIPanGestureRecognizer* panGesture;
@property(nonatomic, retain)UILabel* headerTitle;
@property(nonatomic, retain)UILabel* headerSubtitle;
@property(nonatomic, retain)UIButton* twitterCellIcon;
@property(nonatomic, retain)UILabel* twitterCellTitle;
@property(nonatomic, retain)UILabel* twitterCellSubtitle;
@property(nonatomic, retain)UIButton* githubCellIcon;
@property(nonatomic, retain)UILabel* githubCellTitle;
@property(nonatomic, retain)UILabel* githubCellSubtitle;
@property(nonatomic, retain)UIButton* discordCellIcon;
@property(nonatomic, retain)UILabel* discordCellTitle;
@property(nonatomic, retain)UILabel* discordCellSubtitle;
@property(nonatomic, retain)UILabel* hintLabel;
@end