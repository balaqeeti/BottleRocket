//
//  RestaurantCollectionViewCell.h
//  BottleRocket
//
//  Created by admin on 12/17/16.
//  Copyright © 2016 Jett Raines. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;

@interface RestaurantCollectionViewCell : UICollectionViewCell

- (void)updateUI:(nonnull Restaurant*)restaurant;

@end
