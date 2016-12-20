//
//  HTTPService.m
//  BottleRocket
//
//  Created by admin on 12/16/16.
//  Copyright © 2016 Jett Raines. All rights reserved.
//

#import "HTTPService.h"
#define URL_BASE "http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/restaurants.json"

@implementation HTTPService

+ (id)instance
{
    static HTTPService *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)getRestaurantData:(nullable onComplete)completionHandler
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s", URL_BASE]];
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (data != nil)
        {
            NSError *err;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options: 0 error:&err];
            if (error == nil)
            {
                completionHandler(json, nil);
               // NSLog(@"JSON: %@", json.debugDescription);
            }
            else
            {
                completionHandler(nil, @"Data is corrupt please try again");
            }
        }
        else
        {
            NSLog(@"NetworkErr: %@", error.debugDescription);
            completionHandler(nil, @"Problem connecting to the Server");
        }
    }] resume];
}

@end
