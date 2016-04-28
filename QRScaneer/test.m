
//
//  test.m
//  QRScaneer
//
//  Created by Venkata Srujan Chalasani on 12/4/15.
//  Copyright © 2015 Harsh Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "CheckOutViewController.h"
#import "test.h"
#import "BarCodeViewController.h"

@interface test()
@property (nonatomic,strong) NSMutableArray *names;

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *bc1;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSNumber *sum;

@end


@implementation test




- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // This table displays items in the Todo class
          self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        
          }
    return self;
}

//Get the queries
- (PFQuery *)queryForTable {
    
    //Get the table
        PFQuery *query = [PFQuery queryWithClassName:@"Items"];
   
    if (_bc!=nil) {
        
        _bc1=_bc;
        //Get the item with the fetched barcode
        [query whereKey:@"Barcode" equalTo:_bc];
       
        //Return the objects from the original database
        PFObject *f= [query getFirstObject];
        _name = f[@"Name"];
        _price=f[@"Price"];
        _names = [NSMutableArray arrayWithObjects:_name,nil];
        PFObject *myPost;
        
        //Post the details in the cart database
        myPost = [PFObject objectWithClassName:_tName];
        myPost[@"Barcode"] = _bc;
        myPost[@"Name"] = _name;
        myPost[@"Price"] =_price;
        [myPost saveInBackground];
        _bc=nil;
        _bc1=nil;
        
    }
    
    PFQuery *query2 = [PFQuery queryWithClassName:_tName];
    //return query;
    return query2;

    }


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(nullable PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
    
    
    //Display the items in the cells
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
                        }
        UILabel *label,*label1;
        
        label = (UILabel *)[cell viewWithTag:1];
        label.text = [object objectForKey:@"Name"];
        
        label1 = (UILabel *)[cell viewWithTag:2];
        NSNumber* x = [object valueForKey:@"Price"];
        int y = [x intValue];
        NSString *xy = [NSString stringWithFormat:@"%d",y];
        
        label1.text =xy;
    
        return cell;
    
}
//Send the tablename to next view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"barCode"]) {
        
        // Get destination view
        BarCodeViewController *bvc = [segue destinationViewController];
        bvc.colName = _tName;
    }

     if ([[segue identifier] isEqualToString:@"checkOut"]) {
         
         
         CheckOutViewController *cv = (CheckOutViewController *)[[segue destinationViewController] topViewController];
         cv.className = _tName;
         
         //Saving the Reciept in the photos
         CGRect screenRect = [[UIScreen mainScreen] bounds];
         UIGraphicsBeginImageContext(screenRect.size);
         CGContextRef ctx = UIGraphicsGetCurrentContext();
         [[UIColor blackColor] set];
         CGContextFillRect(ctx, screenRect);
         
         // grab reference to our window
         UIWindow *window = [UIApplication sharedApplication].keyWindow;
         
         // transfer content into our context
         [window.layer renderInContext:ctx];
         UIImage *screengrab = UIGraphicsGetImageFromCurrentImageContext();
         UIGraphicsEndImageContext();
         UIImageWriteToSavedPhotosAlbum(screengrab, nil, nil, nil);
         

     
     }
}


- (void)tableView:(UITableView *) tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath*)indexPath{
    
    PFObject *object=[self.objects objectAtIndex:indexPath.row];
    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        [tableView reloadData];
    }];
    

}

@end

