//
//  ViewController.m
//  QRScaneer
//
//  Created by Harsh Gupta on 12/3/15.
//  Copyright © 2015 Harsh Gupta. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"



@interface ViewController () <MKMapViewDelegate> {

    
    __weak IBOutlet MKMapView *myMapView;
    
    CLLocationManager *locatioManager;
    NSString *name;
    NSString *phone;

}


@end

@implementation ViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor clearColor];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    
    myMapView.showsUserLocation = YES;
    myMapView.showsBuildings = YES;
    
    //Get location of the user
    locatioManager = [CLLocationManager new];
    if ([locatioManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locatioManager requestWhenInUseAuthorization];
    }
    [locatioManager startUpdatingLocation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    //Perform a query to get the nearby walmart stores
    MKLocalSearchRequest *request =
    [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = @"walmart";
    request.region = myMapView.region;
   
    
    MKLocalSearch *search =
    [[MKLocalSearch alloc]initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse
                                         *response, NSError *error) {
        if (response.mapItems.count == 0)
        {
            NSLog(@"No Matches");
        }
        else
            for (MKMapItem *item in response.mapItems)
            {
               //Display the annotations for the map
                MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
                
                annotation.coordinate = item.placemark.coordinate;
                annotation.title = item.name;
                
                [myMapView addAnnotation:annotation];
                
                annotation.subtitle=item.phoneNumber;
                
            }
    }];
    //Use the MKMap camera to zoom to user location
    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:userLocation.coordinate fromEyeCoordinate:CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude) eyeAltitude:10000];
    [mapView setCamera:camera animated:YES];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    //The annotaions are being customized
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    //get the selected annotation
    [mapView selectAnnotation:[[mapView annotations] objectAtIndex:0] animated:YES];
   
       name = view.annotation.title;
    phone=@"";
  
    phone = view.annotation.subtitle;
      NSLog(@"%@",phone);
    
    [self performSegueWithIdentifier:@"Details" sender:view];
    
    }


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Details"]) {
        
        // Get destination view and send the image
        MKMapSnapshotOptions *options = [MKMapSnapshotOptions new];
        options.region = myMapView.region;
        options.size =  myMapView.frame.size;
        options.mapType = MKMapTypeSatellite;
        options.showsBuildings = YES;
        options.scale = [[UIScreen mainScreen] scale];
        
        //Send the phone number and name
        DetailViewController *dvc =[segue destinationViewController];
        dvc.options = options;
        dvc.phno=phone;
        dvc.name=name;
    }
}

@end

