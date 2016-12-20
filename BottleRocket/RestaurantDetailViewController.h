//
//  RestaurantDetailViewController.h
//  BottleRocket
//
//  Created by admin on 12/18/16.
//  Copyright © 2016 Jett Raines. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class Restaurant;

@interface RestaurantDetailViewController : UIViewController 
@property (nonatomic, strong) Restaurant *restaurant;

@end
