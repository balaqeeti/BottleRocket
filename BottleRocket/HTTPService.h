//
//  HTTPService.h
//  BottleRocket
//
//  Created by admin on 12/16/16.
//  Copyright © 2016 Jett Raines. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^onComplete)(NSDictionary * __nullable dataDict, NSString * __nullable errMessage);

@interface HTTPService : NSObject

+ (id) instance;
- (void)getRestaurantData:(nullable onComplete)completionHandler;

@end
