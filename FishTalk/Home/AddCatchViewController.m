//
//  AddCatchViewController.m
//  FishTalk
//
//  Created by Ahmed Mostafa Hanafy on 2/29/16.
//  Copyright © 2016 Ahmed Mostafa Hanafy. All rights reserved.
//

#import "AddCatchViewController.h"

@interface AddCatchViewController ()

@end

@implementation AddCatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    _imageIsExist = NO;
    _user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Text Field Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _catchTitleTextField)
    {
        [_addLocationTextField becomeFirstResponder];
        return YES;
    }
    else if (textField == _addLocationTextField)
    {
        [_dateTextField becomeFirstResponder];
        return YES;
    }
    else if (textField == _dateTextField)
    {
        [_lengthTextField becomeFirstResponder];
        return YES;
    }
    else if (textField == _lengthTextField)
    {
        [_weightTextField becomeFirstResponder];
        return YES;
    }
    else if (textField == _weightTextField)
    {
        [_speciesTextField becomeFirstResponder];
        return YES;
    }
    else if (textField == _speciesTextField)
    {
        [_anglingTextField becomeFirstResponder];
        return YES;
    }
    else
    {
        [textField resignFirstResponder];
        return NO;
    }
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    if (textField == _weightTextField)
    {
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 30.0), self.view.frame.size.width, self.view.frame.size.height);
    }
    else if (textField == _speciesTextField)
    {
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 60.0), self.view.frame.size.width, self.view.frame.size.height);
    }
    else if (textField == _anglingTextField)
    {
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 90.0), self.view.frame.size.width, self.view.frame.size.height);
    }
    [UIView commitAnimations];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    if (textField == _weightTextField)
    {
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y + 30.0), self.view.frame.size.width, self.view.frame.size.height);
    }
    else if (textField == _speciesTextField)
    {
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y + 60.0), self.view.frame.size.width, self.view.frame.size.height);
    }
    else if (textField == _anglingTextField)
    {
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y + 90.0), self.view.frame.size.width, self.view.frame.size.height);
    }
    [UIView commitAnimations];
}

#pragma mark - Actions
- (IBAction)addImageClicked:(id)sender
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Choose"
                                 message:@"Take photo from"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* camera = [UIAlertAction
                             actionWithTitle:@"Camera"
                             
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self openCamera];
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
    UIAlertAction* gallery = [UIAlertAction
                              actionWithTitle:@"Gallery"
                              
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  [self selectPhoto];
                                  [alert dismissViewControllerAnimated:YES completion:nil];
                              }];
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
    [alert addAction:camera];
    [alert addAction:gallery];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)cancelClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Image Picker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    [_catchImageView setImage:chosenImage];
    _imageIsExist = YES;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)openCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    else{
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.delegate = self;
        self.picker.allowsEditing = YES;
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:self.picker animated:YES completion:NULL];
    }
    
}
- (void)selectPhoto {
    
    self.picker= [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    self.picker.allowsEditing = YES;
    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:self.picker animated:YES completion:NULL];
    
}

- (IBAction)savePressed:(id)sender {
    
    if (![_catchTitleTextField.text isEqualToString:@""]) {
        
        MBProgressHUD *spinningProgress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        spinningProgress.labelText = @"Please wait";
        spinningProgress.mode = MBProgressHUDModeAnnularDeterminate;
        
        NSMutableDictionary *parameters = [NSMutableDictionary new];
        
        parameters[@"title"] = _catchTitleTextField.text;
        parameters[@"ownerEmail"] = _user[@"email"];
        parameters[@"location"] = _addLocationTextField.text;
        parameters[@"length"] = _lengthTextField.text;
        parameters[@"weight"] = _weightTextField.text;
        parameters[@"species"] = _speciesTextField.text;
        parameters[@"anglingMethod"] = _anglingTextField.text;
        
        NSDate *currDate = [NSDate date];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
        
        NSString *dateString = [dateFormatter stringFromDate:currDate];
        dateString = [NSString stringWithFormat:@"%@%@",dateString, @".jpg"];
        
        NSString * url = [NSString stringWithFormat:@"%@%@",
                          @"http://ios.com.magenta.mysitehosted.com/fishtalk/images/", dateString];
        
        parameters[@"photo"] = url;
        
        UIImage *uploadedImage;
        
        if (_imageIsExist) {
            
            uploadedImage = _catchImageView.image;
        } else {
            
            uploadedImage = [UIImage imageNamed:@"pic1.png"];
        }
        
        [manager POST:@"http://ios.com.magenta.mysitehosted.com/fishtalk/addAcatch.php" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            NSData *imageData = UIImageJPEGRepresentation(uploadedImage, 0.5);
            [formData appendPartWithFileData:imageData name:@"userfile" fileName:dateString mimeType:@"image/jpeg"];
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            spinningProgress.progress = uploadProgress.fractionCompleted;
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"response = %@", responseObject);
            
            spinningProgress.hidden = YES;
            
            if ([responseObject[@"success"] boolValue]) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
            } else {
                
                [self showAlertWithMasseage:@"Something went wrong, Please try again later"];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"error = %@", error);
            spinningProgress.hidden = YES;
            
            [self showAlertWithMasseage:@"Please, check your internet connection"];
        }];

    }
}

- (void) showAlertWithMasseage:(NSString *) message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"OOPS" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
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
