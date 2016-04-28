//
//  CheckOutViewController.h
//  QRScaneer
//
//  Created by Harsh Gupta on 12/9/15.
//  Copyright © 2015 Harsh Gupta. All rights reserved.
//

#import <ParseUI/ParseUI.h>

@interface CheckOutViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *totalPrice;
@property (strong, nonatomic) NSString *className;
@property (nonatomic,strong) NSMutableArray *names;
@property (nonatomic,strong) NSMutableArray *itemsArray;
- (IBAction)payButton:(UIButton *)sender;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *bc1;
@end
