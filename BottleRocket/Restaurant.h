//
//  Restaurant.h
//  BottleRocket
//
//  Created by admin on 12/17/16.
//  Copyright © 2016 Jett Raines. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Restaurant : NSObject
@property(nonatomic,strong) NSString *restaurantTitle;
@property(nonatomic,strong) NSString *restaurantImageURL;
@property(nonatomic,strong) NSString *restaurantCategory;
@property(nonatomic,strong) NSString *restaurantAddressLineOne;
@property(nonatomic,strong) NSString *restaurantAddressLineTwo;
@property(nonatomic,strong) NSString *restaurantPhoneNumber;
@property(nonatomic,strong) NSString *restaurantTwitterHandle;
@property(nonatomic,strong) NSNumber *restaurantLatitude;
@property(nonatomic,strong) NSNumber *restaurantLongitude;
@property(nonatomic,strong) UIImage *restaurantImage;
@end
