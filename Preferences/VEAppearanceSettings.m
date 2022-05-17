#import "VERootListController.h"

@implementation VEAppearanceSettings

- (UIColor *)tintColor {

    return [UIColor colorWithRed:0.58 green:0.45 blue:0.94 alpha:1];

}

- (UIStatusBarStyle)statusBarStyle {

    return UIStatusBarStyleLightContent;

}

- (UIColor *)navigationBarTitleColor {

    return [UIColor whiteColor];

}

- (UIColor *)navigationBarTintColor {

    return [UIColor whiteColor];

}

- (UIColor *)tableViewCellSeparatorColor {

    return [UIColor clearColor];

}

- (UIColor *)navigationBarBackgroundColor {

    return [UIColor colorWithRed:0.58 green:0.45 blue:0.94 alpha:1];

}

- (BOOL)translucentNavigationBar {

    return YES;

}

@end