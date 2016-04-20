//
//  CatchesCollectionViewCell.h
//  FishTalk
//
//  Created by Ahmed Mostafa Hanafy on 2/29/16.
//  Copyright © 2016 Ahmed Mostafa Hanafy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatchesCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *catchPic;
@property (weak, nonatomic) IBOutlet UIImageView *catchUserPic;
@property (weak, nonatomic) IBOutlet UIImageView *heartPic;
@property (weak, nonatomic) IBOutlet UILabel *catchNumberOfLiked;

@end
