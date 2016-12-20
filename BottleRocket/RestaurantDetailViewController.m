//
//  RestaurantDetailViewController.m
//  BottleRocket
//
//  Created by admin on 12/18/16.
//  Copyright © 2016 Jett Raines. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import "Restaurant.h"
@import GoogleMaps;

@interface RestaurantDetailViewController ()
@property (weak, nonatomic) IBOutlet GMSMapView *gMapView;
@property (weak, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantAddressLineOne;
@property (weak, nonatomic) IBOutlet UILabel *restaurantAddressLineTwo;
@property (weak, nonatomic) IBOutlet UILabel *restaurantPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *restaurantTwitterHandle;

@end

@implementation RestaurantDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Add Restaurant Marker to MapView
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: self.restaurant.restaurantLatitude.doubleValue
                                                            longitude: self.restaurant.restaurantLongitude.doubleValue zoom: 11];
    GMSMapView *mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    
    [self.gMapView animateToCameraPosition:camera];
    NSLog(@"%f", self.restaurant.restaurantLatitude.doubleValue);
    GMSMarker *marker = [ [GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(self.restaurant.restaurantLatitude.doubleValue, self.restaurant.restaurantLongitude.doubleValue);
    marker.title = self.restaurant.restaurantTitle;
    marker.snippet = self.restaurant.restaurantCategory;
    marker.map = self.gMapView;
    
    self.gMapView = mapView;

    // Set UILabels from Restuarant info
    self.restaurantNameLabel.text = self.restaurant.restaurantTitle;
    self.restaurantCategoryLabel.text = self.restaurant.restaurantCategory;
    self.restaurantAddressLineOne.text = self.restaurant.restaurantAddressLineOne;
    self.restaurantAddressLineTwo.text = self.restaurant.restaurantAddressLineTwo;
    self.restaurantPhoneNumber.text = self.restaurant.restaurantPhoneNumber;
    // Handle the twitter handle hehe ;P
    if (self.restaurant.restaurantTwitterHandle != nil)
    {
        NSString *twitterWithSymbol = [NSString stringWithFormat:@"%@%@", @"@", self.restaurant.restaurantTwitterHandle];
        self.restaurantTwitterHandle.text = twitterWithSymbol;
    }
    else
    {
        self.restaurantTwitterHandle.text = self.restaurant.restaurantTwitterHandle;
    }
}

@end
