//
//  SplashViewController.m
//  QRScaneer
//
//  Created by Venkata Srujan Chalasani on 12/8/15.
//  Copyright © 2015 Harsh Gupta. All rights reserved.
//

#import "SplashViewController.h"
#import "VENTouchLock.h"

@interface SplashViewController ()


@end

@implementation SplashViewController

- (instancetype)init
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        self.didFinishWithSuccess = ^(BOOL success, VENTouchLockSplashViewControllerUnlockType unlockType) {
            if (success) {
                NSString *logString = @"App Unlocked";
                switch (unlockType) {
                    case VENTouchLockSplashViewControllerUnlockTypeTouchID: {
                        
                        //App has been Unlocked with Touch ID
                        logString = [logString stringByAppendingString:@" with Touch ID."];
                        break;
                    }
                    case VENTouchLockSplashViewControllerUnlockTypePasscode: {
                        
                        //App has been Unlocked with Touch ID
                        logString = [logString stringByAppendingString:@" with Passcode."];
                        break;
                    }
                    default:
                        break;
                }
                NSLog(@"%@", logString);
            }
            else {
                [[[UIAlertView alloc] initWithTitle:@"Limit Exceeded"
                                            message:@"You have exceeded the maximum number of passcode attempts"
                                           delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil] show];
            }
        };
    }
    return self;
}

//The user should use Touch iD
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.touchIDButton.hidden = ![VENTouchLock shouldUseTouchID];
}

//User pressed login with Touch iD
- (IBAction)userTappedShowTouchID:(id)sender
{
    [self showTouchID];
}

//User pressed login with Passcode.
- (IBAction)userTappedEnterPasscode:(id)sender
{
    [self showPasscodeAnimated:YES];
}

@end
