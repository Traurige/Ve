#import "VeToggle.h"

BOOL enabled = NO;

// control center toggle
BOOL isLoggingTemporarilyDisabled = NO;

// protection
BOOL biometricProtectionSwitch = NO;

BOOL dontShowToggleWarningAgain = NO;

@implementation VeToggle

- (id)init { // register the preferences

    self = [super init];

    self.preferences = [[HBPreferences alloc] initWithIdentifier:@"love.litten.vepreferences"];
    [[self preferences] registerBool:&enabled default:NO forKey:@"Enabled"];
    [[self preferences] registerBool:&isLoggingTemporarilyDisabled default:NO forKey:@"isLoggingTemporarilyDisabled"];
    [[self preferences] registerBool:&biometricProtectionSwitch default:NO forKey:@"biometricProtection"];
    [[self preferences] registerBool:&dontShowToggleWarningAgain default:NO forKey:@"dontShowToggleWarningAgain"];

    if (enabled) return self;
    else return nil;

}

- (UIImage *)iconGlyph { // set the icon

    return [UIImage imageNamed:@"icon" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];

}

- (UIColor *)selectedColor { // set the selectec color

    return [UIColor colorWithRed:0.58 green:0.45 blue:0.94 alpha:1];

}

- (BOOL)isSelected { // check if the toggle is selected

    return isLoggingTemporarilyDisabled;

}

- (void)setSelected:(BOOL)selected { // do something when the toggle was selected

    [super setSelected:selected];

    if (biometricProtectionSwitch) {
        LAContext* laContext = [LAContext new];
        [laContext evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"Vē needs to make sure that you are permitted to take this action." reply:^(BOOL success, NSError* _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) [[self preferences] setBool:![self isSelected] forKey:@"isLoggingTemporarilyDisabled"];
                else return;
            });
        }];
    } else {
        [[self preferences] setBool:![self isSelected] forKey:@"isLoggingTemporarilyDisabled"];
    }

    if (isLoggingTemporarilyDisabled && !dontShowToggleWarningAgain) {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Vē" message:@"Logging is now disabled for the time being." preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* dismissAction = [UIAlertAction actionWithTitle:@"Understood" style:UIAlertActionStyleDefault handler:nil];

        UIAlertAction* dontShowAgainAction = [UIAlertAction actionWithTitle:@"Don't Show Again" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            [[self preferences] setBool:YES forKey:@"dontShowToggleWarningAgain"];
        }];

        [alertController addAction:dismissAction];
        [alertController addAction:dontShowAgainAction];

        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
    }

}

@end
