//
//  FirstViewController.m
//  BottleRocket
//
//  Created by admin on 12/16/16.
//  Copyright © 2016 Jett Raines. All rights reserved.
//

#import "RestaurantCollectionViewController.h"
#import "HTTPService.h"
#import "Restaurant.h"
#import "RestaurantCollectionViewCell.h"
#import "RestaurantDetailViewController.h"
#import "MapViewController.h"

@interface RestaurantCollectionViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *mapButton;
@property (strong, nonatomic) NSArray *restaurantList;
@property (strong, nonatomic) NSDictionary *restaurantDict;
@property (strong, nonatomic) NSCache *imageCache;
@end

@implementation RestaurantCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
     //Configure cell layout
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [self.flowLayout setItemSize: CGSizeMake(self.collectionView.bounds.size.width, 180)];
        [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        self.flowLayout.minimumLineSpacing = 0;
        [self.collectionView setCollectionViewLayout:self.flowLayout];
        self.collectionView.bounces = YES;
        [self.collectionView setShowsHorizontalScrollIndicator:NO];
        [self.collectionView setShowsVerticalScrollIndicator:NO];

    self.restaurantList = [[NSMutableArray alloc]init];
    
    [[HTTPService instance]getRestaurantData:^(NSDictionary * _Nullable dataDict, NSString * _Nullable errMessage)
     {
        if (dataDict)
        {
            NSArray *dataArr = [[NSArray alloc]init];
            dataArr = [dataDict objectForKey:@"restaurants"];
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            for (NSDictionary *d in dataArr)
            {
                Restaurant *restaurant = [[Restaurant alloc]init];
                restaurant.restaurantTitle = [d objectForKey:@"name"];
                restaurant.restaurantImageURL = [d objectForKey:@"backgroundImageURL"];
                restaurant.restaurantCategory = [d objectForKey:@"category"];
            
                NSDictionary *contactDict = [d objectForKey:@"contact"];
                
                if (contactDict != (id)[NSNull null])
                {
                    restaurant.restaurantPhoneNumber = [contactDict objectForKey:@"formattedPhone"];
                    restaurant.restaurantTwitterHandle = [contactDict objectForKey:@"twitter"];
                }
                
                NSDictionary *locationDict = [d objectForKey:@"location"];
                restaurant.restaurantLatitude = [locationDict objectForKey:@"lat"];
                restaurant.restaurantLongitude = [locationDict objectForKey:@"lng"];

                restaurant.restaurantAddressLineOne = [locationDict objectForKey:@"address"];
                NSArray *addressArray = [locationDict objectForKey:@"formattedAddress"];
                restaurant.restaurantAddressLineTwo = [addressArray objectAtIndex:1];
                
                 UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:restaurant.restaurantImageURL]]];
                [self.imageCache setObject:image forKey:restaurant.restaurantTitle];
                
                restaurant.restaurantImage = image;
                
                [arr addObject:restaurant];
                [dict setObject:locationDict forKey:restaurant.restaurantTitle];
                
            }
            self.restaurantList = arr;
            self.restaurantDict = dict;
            [self updateCollectionViewData];
            }
            else if (errMessage)
            {
                NSLog(@"%@", errMessage.debugDescription);
            }
     }];
    
}

- (void)updateCollectionViewData
{
    dispatch_async(dispatch_get_main_queue(), ^
    {
        [self.collectionView reloadData];
        [self.activityIndicator stopAnimating];
        [self.activityIndicator setHidden:YES];
        
    });
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    RestaurantCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RestaurantCollectionViewCell" forIndexPath:(NSIndexPath *)indexPath];
    
    if (!cell)
    {
        cell = [[RestaurantCollectionViewCell alloc]init];
        
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    Restaurant *restaurant = [self.restaurantList objectAtIndex:indexPath.row];
    RestaurantCollectionViewCell *restaurantCell = (RestaurantCollectionViewCell *)cell;
    [restaurantCell updateUI: restaurant];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Restaurant *restaurant = [self.restaurantList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"goToDetailVC" sender:restaurant];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
        return CGSizeMake(collectionView.frame.size.width, 180);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.restaurantList.count;
}


- (IBAction)mapButtonTapped:(id)sender
{
    [self performSegueWithIdentifier:@"goToMapVC" sender:self.restaurantDict];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"goToDetailVC"])
    {
      RestaurantDetailViewController *vc = (RestaurantDetailViewController *)segue.destinationViewController;
        Restaurant *restaurant = (Restaurant *)sender;
        vc.restaurant = restaurant;
        
    }
    if ([[segue identifier] isEqualToString:@"goToMapVC"])
    {
        MapViewController *vc = (MapViewController *)segue.destinationViewController;
        vc.dict = self.restaurantDict;
    }
    

}

@end


