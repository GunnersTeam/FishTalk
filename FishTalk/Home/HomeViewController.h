//
//  HomeViewController.h
//  FishTalk
//
//  Created by Ahmed Mostafa Hanafy on 2/29/16.
//  Copyright © 2016 Ahmed Mostafa Hanafy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCollectionViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "MBProgressHUD.h"
#import "UIImageView+AFNetworking.h"

@interface HomeViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    
    AFHTTPSessionManager *manager;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *catchesArray;
@property (weak, nonatomic) NSDictionary *user;

@end
