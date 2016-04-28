//
//  MapViewController.h
//  MyMapView Project
//
//  
//  

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>


@interface MapViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISearchBar *ibSearchBar;
@property (strong, nonatomic) IBOutlet MKMapView *ibMapView;



@end
