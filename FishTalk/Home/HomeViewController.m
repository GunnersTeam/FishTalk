//
//  HomeViewController.m
//  FishTalk
//
//  Created by Ahmed Mostafa Hanafy on 2/29/16.
//  Copyright © 2016 Ahmed Mostafa Hanafy. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
  
    _user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getCatches];
}

- (void) getCatches{
    
    MBProgressHUD *spinningProgress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    spinningProgress.labelText = @"Please wait";
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    parameters[@"ownerEmail"] = _user[@"email"];
    
    [manager POST:@"http://ios.com.magenta.mysitehosted.com/fishtalk/myCatches.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"response = %@", responseObject);
        spinningProgress.hidden = YES;
        
        if (responseObject[@"success"]) {
            
            [self fillCatchesArray:responseObject[@"result"]];
            [_collectionView reloadData];
        } else {
            
            [self showAlertWithMasseage:@"You have no catches"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error = %@", error);
        spinningProgress.hidden = YES;
        
        [self showAlertWithMasseage:@"Please, check your internet connection"];
    }];

}

- (void) fillCatchesArray:(NSArray *) catches{
    
    _catchesArray = [NSMutableArray new];
    
    for (int i = 0; i < [catches count]; i++) {
        
        NSDictionary *catch = catches[i];
        
        [_catchesArray addObject:catch[@"photo"]];
    }
}
- (void) showAlertWithMasseage:(NSString *) message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"OOPS" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)friendsClicked:(id)sender {
}

- (IBAction)publicClicked:(id)sender {
}

#pragma mark - Collection View

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_catchesArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell" forIndexPath:indexPath];
    cell.homeProfilePic.layer.cornerRadius = cell.homeProfilePic.frame.size.width/2;
    cell.homeProfilePic.clipsToBounds = YES;
    cell.homeCatchPic.image = nil;
    [self loadImage:cell.homeCatchPic withURL:_catchesArray[indexPath.row]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)loadImage:(__weak UIImageView*)imageView withURL:(NSString*)imageURL
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    
    indicator.center = CGPointMake(CGRectGetMidX(imageView.layer.bounds), CGRectGetMidY(imageView.layer.bounds));
    
    [imageView addSubview:indicator];
    
    NSURL *url = [NSURL URLWithString:imageURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [imageView setImageWithURLRequest:request
                     placeholderImage:nil
                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                  
                                  imageView.image = image;
                                  indicator.hidden=YES;
                                  [indicator removeFromSuperview];
                                  
                              } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                  
                                  indicator.hidden=YES;
                                  [indicator removeFromSuperview];
                              }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
