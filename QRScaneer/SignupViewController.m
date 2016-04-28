//
//  SignupViewController.m
//  QRScaneer
//
//  Created by Venkata Srujan Chalasani on 12/13/15.
//  Copyright © 2015 Harsh Gupta. All rights reserved.
//

#import "SignupViewController.h"
#import "Parse/Parse.h"
#import "LogInViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad {
    self.title = @"Sign up!";
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signupPressed:(UIButton *)sender {
    if(self.Username.text==nil||[self.Username.text isEqualToString:@""]){
        //[self.alertLabel setText:@"Username Required"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Message"
                                                        message:@"Username Required"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        //[alert release];
        return;
    }
    if(self.Password.text==nil||[self.Password.text isEqualToString:@""]){
        //[self.alertLabel setText:@"Password Required"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Message"
                                                        message:@"Password Required"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    if(self.Email.text==nil||[self.Email.text isEqualToString:@""]){
        //[self.alertLabel setText:@"Email Required"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Message"
                                                        message:@"Email Required"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    PFUser *user=[PFUser user];
    user.username=self.Username.text;
    user.password=self.Password.text;
    user.email=self.Email.text;
    
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(!error){
            //[self.alertLabel setText:@"Signup Complete"];
            [self performSegueWithIdentifier:@"signUp" sender:self];
            
        }
        else{
            NSString *errorString = [error userInfo][@"error"];
            [self.alertLabel setText:[NSString stringWithFormat:@"Signup Error:%@", errorString]];
        }
    }];
}

    
        
@end
