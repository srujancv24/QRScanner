//
//  DetailViewController.h
//  QRScaneer
//
//  Created by Venkata Srujan Chalasani on 12/9/15.
//  Copyright © 2015 Harsh Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface DetailViewController : UIViewController
- (IBAction)call:(id)sender;
@property (strong, nonatomic) NSString  *phno;
@property (strong, nonatomic) NSString  *name;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *name1;
@property MKMapSnapshotOptions *options;
- (NSString *)randomgen:(NSInteger)length;
@end
