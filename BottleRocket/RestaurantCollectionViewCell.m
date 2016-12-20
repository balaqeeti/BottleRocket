//
//  RestaurantCollectionViewCell.m
//  BottleRocket
//
//  Created by admin on 12/17/16.
//  Copyright © 2016 Jett Raines. All rights reserved.
//

#import "RestaurantCollectionViewController.h"
#import "RestaurantCollectionViewCell.h"
#import "Restaurant.h"

@interface RestaurantCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *restaurantCategory;

@end

@implementation RestaurantCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.cornerRadius = 2.0;
    self.layer.shadowColor = [UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha: 0.8].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowOffset = CGSizeMake(0.0, 2.0);
}

- (void)updateUI:(nonnull Restaurant *)restaurant
{
    self.restaurantName.text = restaurant.restaurantTitle;
    self.restaurantCategory.text = restaurant.restaurantCategory;
    self.restaurantImage.image = restaurant.restaurantImage;
}

@end
