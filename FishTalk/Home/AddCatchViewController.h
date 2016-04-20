//
//  AddCatchViewController.h
//  FishTalk
//
//  Created by Ahmed Mostafa Hanafy on 2/29/16.
//  Copyright © 2016 Ahmed Mostafa Hanafy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "MBProgressHUD.h"

@interface AddCatchViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    
    AFHTTPSessionManager *manager;
}

@property(strong, nonatomic) UIImagePickerController * picker;
@property (weak, nonatomic) IBOutlet UITextField *catchTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *addLocationTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *lengthTextField;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *speciesTextField;
@property (weak, nonatomic) IBOutlet UITextField *anglingTextField;
@property (weak, nonatomic) IBOutlet UIImageView *catchImageView;

@property (assign, nonatomic) BOOL imageIsExist;
@property (weak, nonatomic) NSDictionary *user;

@end
