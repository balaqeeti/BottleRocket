//
//  MapViewController.m
//  BottleRocket
//
//  Created by admin on 12/19/16.
//  Copyright © 2016 Jett Raines. All rights reserved.
//

#import "MapViewController.h"
@import GoogleMaps;


@interface MapViewController ()
@property (weak, nonatomic) IBOutlet GMSMapView *gMapView;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: 32.95347617827522
                                                            longitude: -96.82554602622986 zoom: 12];
    GMSMapView *mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    
    [self.gMapView animateToCameraPosition:camera];
    // Take Keys from dict, make array, then search dict and create markers for given restaurant
    NSArray *keyArray = [self.dict allKeys];
    for (NSString *key in keyArray)
    {
        NSDictionary *restaurantDict = [self.dict objectForKey:key];
        GMSMarker *marker = [ [GMSMarker alloc] init];
        NSNumber *lat = [restaurantDict objectForKey:@"lat"];
        NSNumber *lng = [restaurantDict objectForKey:@"lng"];
        marker.position = CLLocationCoordinate2DMake(lat.doubleValue,lng.doubleValue);
        marker.title = key;
        marker.map = self.gMapView;
    }
    self.gMapView = mapView;
}

- (IBAction)backToFeedTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
