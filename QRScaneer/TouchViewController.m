//
//  TouchViewController.m
//  QRScaneer
//
//  Created by Venkata Srujan Chalasani on 12/8/15.
//  Copyright © 2015 Harsh Gupta. All rights reserved.
//

#import "TouchViewController.h"
#import "VENTouchLock.h"

@interface TouchViewController ()
@end

@implementation TouchViewController


- (void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor clearColor];
    [super viewWillAppear:animated];
    [self configureTouchIDToggle];
}

- (void)configureTouchIDToggle
{
    self.touchIDSwitch.enabled = [[VENTouchLock sharedInstance] isPasscodeSet] && [VENTouchLock canUseTouchID];
    self.touchIDSwitch.on = [VENTouchLock shouldUseTouchID];
}

//The user is setting the passcode
- (IBAction)userTappedSetPasscode:(id)sender
{
    if ([[VENTouchLock sharedInstance] isPasscodeSet]) {
        [[[UIAlertView alloc] initWithTitle:@"Passcode already exists" message:@"To set a new one, first delete the existing one" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else {
        VENTouchLockCreatePasscodeViewController *createPasscodeVC = [[VENTouchLockCreatePasscodeViewController alloc] init];
        [self presentViewController:[createPasscodeVC embeddedInNavigationController] animated:YES completion:nil];
    }
}
//The user wants to see the Touch ID
- (IBAction)userTappedShowPasscode:(id)sender
{
    if ([[VENTouchLock sharedInstance] isPasscodeSet]) {
        VENTouchLockEnterPasscodeViewController *showPasscodeVC = [[VENTouchLockEnterPasscodeViewController alloc] init];
        [self presentViewController:[showPasscodeVC embeddedInNavigationController] animated:YES completion:nil];
    }
    else {
        [[[UIAlertView alloc] initWithTitle:@"No passcode" message:@"Please set a passcode first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

//The user deletes the passcode
- (IBAction)userTappedDeletePasscode:(id)sender
{
    if ([[VENTouchLock sharedInstance] isPasscodeSet]) {
        [[VENTouchLock sharedInstance] deletePasscode];
        [self configureTouchIDToggle];
    }
    else {
        [[[UIAlertView alloc] initWithTitle:@"No passcode" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

//The user can choose to use touch id
- (IBAction)userTappedSwitch:(UISwitch *)toggle
{
    [VENTouchLock setShouldUseTouchID:toggle.on];
}

@end