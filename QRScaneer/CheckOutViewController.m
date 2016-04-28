//
//  CheckOutViewController.m
//  QRScaneer
//
//  Created by Harsh Gupta on 12/9/15.
//  Copyright © 2015 Harsh Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "CheckOutViewController.h"

@interface CheckOutViewController()

@end


@implementation CheckOutViewController

- (void)viewDidLoad
{
    self.title=@"Check Out";
    [super viewDidLoad];
    
    //Fetching the query
    PFQuery * cart = [PFQuery queryWithClassName:_className];
    [cart orderByDescending:@"createdAt"];
    
    //Get the price of the ites in the User's Cart
    [cart findObjectsInBackgroundWithBlock:^(NSArray * items, NSError * error) {
        
        if (error) {
            NSLog(@"ERROR: There was an error with the Query for Games!");
        }
        else
            {   //Calculate the TotalAmount
                _itemsArray = [[NSMutableArray alloc] initWithArray:items];
                int totalAmt=0;
                for (int x = 0; x < _itemsArray.count; x++) {
                NSNumber *price = [[_itemsArray objectAtIndex:x] objectForKey:@"Price"];
                int cost = [price intValue];
                totalAmt += cost;
                
            }
            
            self.totalPrice.text=[NSString stringWithFormat:@"%d",totalAmt];
        }
    }];
    }
//If the payment is successful, Give a confirmation Alert.
- (IBAction)payButton:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                    message:@"Payment Confirmed, Thank you!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

}
@end

