//
//  FriendsViewController.h
//  FishTalk
//
//  Created by Ahmed Mostafa Hanafy on 2/29/16.
//  Copyright © 2016 Ahmed Mostafa Hanafy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsTableViewCell.h"

@interface FriendsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
