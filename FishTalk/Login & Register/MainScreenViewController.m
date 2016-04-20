//
//  MainScreenViewController.m
//  FishTalk
//
//  Created by Ahmed Mostafa Hanafy on 2/29/16.
//  Copyright © 2016 Ahmed Mostafa Hanafy. All rights reserved.
//

#import "MainScreenViewController.h"
#import "HomeViewController.h"
#import "FriendsViewController.h"
#import "CatchesViewController.h"

@interface MainScreenViewController ()

@end

@implementation MainScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    _isSignUp = YES;
    _viewY = self.view.frame.origin.y;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hideAndShowKeyboard];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == _emailTextField) {
        
        [_passwordTextField becomeFirstResponder];
        
    } else if (textField == _passwordTextField){
        
        //[self hideAndShowKeyboard];
        [self nextPressed:nil];
    }
    
    return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    //NSLog(@"textFieldShouldBeginEditing");
    //[self hideAndShowKeyboardWithY:-250 AndDuration:.4 AndResign:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    return YES;
}

- (void)keyboardWasShown:(NSNotification *)notification
{
    
    // Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    //Given size may not account for screen rotation
    int height = MIN(keyboardSize.height,keyboardSize.width);
    //int width = MAX(keyboardSize.height,keyboardSize.width);
    
    //your other code here..........
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.frame = CGRectMake(0, _viewY - height, self.view.frame.size.width, self.view.frame.size.height);
       /* CGPoint arrowCenter = _arrow.center;
        arrowCenter.y -= height;
        _arrow.center = arrowCenter;*/
    }];
}


- (void) hideAndShowKeyboard{
    
    [UIView setAnimationDuration:0.5];
    
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view endEditing:YES];
    
    [UIView commitAnimations];
      
}

#pragma mark - Validate
-(NSString*)validateFields
{
    if (_emailTextField.text.length == 0 && _passwordTextField.text.length == 0)
    {
        return @"Please write your username and password.";
    }
    else if (_emailTextField.text.length == 0 && _passwordTextField.text.length != 0)
    {
        return @"Please write your username.";
    }
    else if (_emailTextField.text.length != 0 && _passwordTextField.text.length == 0)
    {
        return @"Please write your password.";
    }
    return @"all done";
}

#pragma mark - Actions
- (IBAction)loginClicked:(id)sender {
   
    //[self.view endEditing:YES];
    [self animateArrowWithButton:sender AndButton2:_signUpButton];
    _isSignUp = NO;
}

- (IBAction)signupPressed:(id)sender {
    
    //[self.view endEditing:YES];
    [self animateArrowWithButton:sender AndButton2:_loginButton];
    _isSignUp = YES;
}

- (IBAction)facebookLoginClicked:(id)sender {
    
}

- (void) animateArrowWithButton:(UIButton *) button AndButton2:(UIButton *) button2{
    
    [UIView animateWithDuration:0.5 animations:^{
       
        CGPoint arrowCenter = _arrow.center;
        arrowCenter.y = button.center.y;
        _arrow.center = arrowCenter;
        
        [button setTitleColor:[UIColor colorWithRed:42.0 / 255 green:196.0 / 255 blue:243.0 / 255 alpha:1] forState:UIControlStateNormal];
        [button setTitleShadowColor:[UIColor colorWithRed:42.0 / 255 green:196.0 / 255 blue:243.0 / 255 alpha:1] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button2 setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button2 setBackgroundColor:[UIColor clearColor]];
    }];
}

- (IBAction)nextPressed:(id)sender {
    
    [self hideAndShowKeyboard];
    
    NSString* validationString = [self validateFields];
    
    if ([validationString isEqualToString:@"all done"])
    {
        
        if (_isSignUp) {
            
            [self loginAndSignup:@"register"];
            
        } else {
            
            
            [self loginAndSignup:@"login"];
        }
    }
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Problem"
                                     message:validationString
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"Ok"
                             
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }

}

- (void) loginAndSignup:(NSString *) operation{
    
    NSString *url = [NSString stringWithFormat:@"http://ios.com.magenta.mysitehosted.com/fishtalk/%@.php", operation];
    
    MBProgressHUD *spinningProgress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    spinningProgress.labelText = @"Please wait";
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    parameters[@"email"] = _emailTextField.text;
    parameters[@"password"] = _passwordTextField.text;
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
        NSLog(@"response = %@", responseObject);
        spinningProgress.hidden = YES;


        if ([responseObject[@"success"] boolValue]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"result"] forKey:@"user"];
            [self navigateToView];
            
        } else {
            
            if (_isSignUp) {
                
                [self showAlertWithMasseage:@"This Account Already Exists"];
            } else {
                
                [self showAlertWithMasseage:@"Please, Enter Correct Email And Password"];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        NSLog(@"error = %@", error);
        spinningProgress.hidden = YES;
        
        [self showAlertWithMasseage:@"Please, check your internet connection"];
    }];
    
}

- (void) showAlertWithMasseage:(NSString *) message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"OOPS" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) navigateToView{
    
    UITabBarController* tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"TabVC"];
    [self.navigationController pushViewController:tabBarController animated:YES];
    
  /*  UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Home" bundle:[NSBundle mainBundle]];
    HomeViewController* mainVC = [storyboard instantiateViewControllerWithIdentifier:@"home"];
    
    storyboard = [UIStoryboard storyboardWithName:@"Friends" bundle:[NSBundle mainBundle]];
    FriendsViewController* friendsVC = [storyboard instantiateViewControllerWithIdentifier:@"friends"];
    
    storyboard = [UIStoryboard storyboardWithName:@"Catches" bundle:[NSBundle mainBundle]];
    CatchesViewController* catchesVC = [storyboard instantiateViewControllerWithIdentifier:@"catches"];
    
    UITabBarController* tabBarController = [[UITabBarController alloc] init];
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    navigationController.navigationBarHidden = YES;
    [tabBarController setViewControllers:[NSArray arrayWithObjects:mainVC, friendsVC, catchesVC, nil]];
    
    [[tabBarController.tabBar.items objectAtIndex:0] setTitle:@"Home"];
    [[tabBarController.tabBar.items objectAtIndex:1] setTitle:@"Friends"];
    [[tabBarController.tabBar.items objectAtIndex:2] setTitle:@"Catches"];
    //        [[tabBarController.tabBar.items objectAtIndex:3] setTitle:@"Locations"];
    
    [[tabBarController.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"Home"]];
    [[tabBarController.tabBar.items objectAtIndex:0] setSelectedImage:[UIImage imageNamed:@"HomeSelected"]];
    [[tabBarController.tabBar.items objectAtIndex:1] setImage:[UIImage imageNamed:@"Friends"]];
    [[tabBarController.tabBar.items objectAtIndex:1] setSelectedImage:[UIImage imageNamed:@"FriendsSelected"]];
    [[tabBarController.tabBar.items objectAtIndex:2] setImage:[UIImage imageNamed:@"Catches"]];
    [[tabBarController.tabBar.items objectAtIndex:2] setSelectedImage:[UIImage imageNamed:@"CatchesSelected"]];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"buttom bar3.png"]];
    //        [[UITabBar appearance] setBackgroundColor:[UIColor colorWithRed:104.0/255.0 green:139.0/255.0 blue:155.0/255.0 alpha:1.0]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:42.0/255.0 green:205.0/255.0 blue:255.0/255.0 alpha:1.0]} forState:UIControlStateSelected];
    
    [tabBarController setSelectedIndex:0];
    
    [self showViewController:navigationController sender:nil];*/
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
