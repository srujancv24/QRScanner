//
//  MapViewController.m
//  MyMapView Project
//
//  
//  
//

#import "MapViewController.h"

@interface MapViewController () <UISearchDisplayDelegate, UISearchBarDelegate>

@end

@implementation MapViewController {
    MKLocalSearch *localSearch;
    MKLocalSearchResponse *results;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.searchDisplayController setDelegate:self];
    [self.ibSearchBar setDelegate:self];
    
    // Zoom the map to current location.
    [self.ibMapView setShowsUserLocation:YES];
    [self.ibMapView setUserInteractionEnabled:YES];
    [self.ibMapView setUserTrackingMode:MKUserTrackingModeFollow];
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    // Cancel any previous searches.
    [localSearch cancel];
    
    // Perform a new search.
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = searchBar.text;
    request.region = self.ibMapView.region;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (error != nil) {
            
            UIAlertController * initWithTitle=   [UIAlertController
                                          alertControllerWithTitle:@"Error"
                                          message:@"Map Error"
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            //Handel your yes please button action here
                                            [initWithTitle dismissViewControllerAnimated:YES completion:nil];
                                            
                                        }];
            
            [initWithTitle addAction:yesButton];
            
            //Return the results of the search
            [self presentViewController:initWithTitle animated:YES completion:nil];
            return;
        }
        
        if ([response.mapItems count] == 0) {
            UIAlertController * initWithTitle=   [UIAlertController
                                                  alertControllerWithTitle:@"Error"
                                                  message:@"No Results"
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            //Handel your yes please button action here
                                            [initWithTitle dismissViewControllerAnimated:YES completion:nil];
                                            
                                        }];
            
            [initWithTitle addAction:yesButton];
            
            
            [self presentViewController:initWithTitle animated:YES completion:nil];
            return;
        }
        results = response;
        
        [self.searchDisplayController.searchResultsTableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [results.mapItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *IDENTIFIER = @"SearchResultsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDENTIFIER];
    }
    
    MKMapItem *item = results.mapItems[indexPath.row];
    
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.placemark.addressDictionary[@"Street"];
    
    return cell;
}



//Place annotations on the map
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchDisplayController setActive:NO animated:YES];
    
    MKMapItem *item = results.mapItems[indexPath.row];
    [self.ibMapView addAnnotation:item.placemark];
    [self.ibMapView selectAnnotation:item.placemark animated:YES];
    
    [self.ibMapView setCenterCoordinate:item.placemark.location.coordinate animated:YES];
    
    [self.ibMapView setUserTrackingMode:MKUserTrackingModeNone];
    
}
//get the selected annotaion
- (MKAnnotationView *)ibMapView:(MKMapView *)ibMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
}

//Send the details to the Details View Controller
- (void)ibMapView:(MKMapView *)ibMapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"Details_Search" sender:view];
}

@end
