//
//  DetailViewController.m
//  QRScaneer
//
//  Created by Venkata Srujan Chalasani on 12/9/15.
//  Copyright © 2015 Harsh Gupta. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"
#import "test.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//Display the satellite view of the location selected.
    MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc] initWithOptions:self.options];
    [snapshotter startWithCompletionHandler:^(MKMapSnapshot *snapshot,    NSError *error) {
        if (error) return; //And show error message;
        [_image setImage:snapshot.image];
    }];
    
    _name1.text=_name;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Generate a random name for the user cart database
-(NSString *)randomgen:(NSInteger)length
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (int i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    
    return randomString;
}
//Send the random name to next view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"table"]) {
        
        // Get destination view
                test *ts = (test *)[[segue destinationViewController] topViewController];
                ts.tName = [self randomgen:5];
    }
    else{
        NSLog(@"No such Segue");
    }
}

//Fetching the phone number of the selected store
- (IBAction)call:(id)sender {
    NSRange range = [_phno rangeOfString:@"+"];
    NSString *trim = [_phno substringWithRange:NSMakeRange(range.location, _phno.length-1)];
    NSLog(@"%@",trim);
   trim = [trim stringByReplacingOccurrencesOfString:@"-" withString:@""];
    trim = [trim stringByReplacingOccurrencesOfString:@" " withString:@""];
   NSString *sru=[@"tel:" stringByAppendingString:trim];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sru] ];
}
@end
