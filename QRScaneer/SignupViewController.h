//
//  SignupViewController.h
//  QRScaneer
//
//  Created by Venkata Srujan Chalasani on 12/13/15.
//  Copyright © 2015 Harsh Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *Username;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UITextField *Email;
@property (weak, nonatomic) IBOutlet UIButton *signUp;
- (IBAction)signupPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;

@end
