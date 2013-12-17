//
//  adcSignInViewController.m
//  ADC
//
//  Created by Steve Ottenad on 11/10/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "adcSignInViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "adcApiSessonManager.h"
#import "adcUserHelper.h"
#import "adcHomeViewController.h"
#import "MBProgressHUD.h"

@interface adcSignInViewController ()

@end

@implementation adcSignInViewController
@synthesize inputPassword, inputUsername, btnSubmit;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //UIImage *barBG = [[UIImage alloc] initWithContentsOfFile:@"top_bar.png"];
    //[self.navigationController.navigationBar setBackgroundImage:barBG forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendLogin:(id)sender
{
    NSString *login = inputUsername.text;
    NSString *password = inputPassword.text;
    adcApiSessonManager *sessionMgr = [adcApiSessonManager sharedManager];
    
    NSDictionary *options = @{ @"password": password, @"username": login };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    
    [sessionMgr GET:@"token/gettoken" parameters:options success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"response:%@", responseObject);
        NSDictionary *respDict = responseObject;
        
        int success = [[respDict valueForKey:@"success"] integerValue];

        if(success == 1){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:[respDict valueForKey:@"auth_token"] forKey:@"auth_token"];
            [defaults setInteger: (int)[respDict valueForKey:@"price_multiplier"] forKey:@"price_multiplier"];
            NSLog(@"%@",respDict);
            [defaults setObject:[respDict valueForKey:@"username"] forKey:@"username"];
            [defaults setObject:[respDict valueForKey:@"user_id"] forKey:@"user_id"];
            [defaults synchronize];
            [self dismissViewControllerAnimated:YES completion:nil];
            [MBProgressHUD hideHUDForView:self.view animated:YES];            
            [self.navigationController popToRootViewControllerAnimated:YES];

        }

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Couldn't Log In"
                                                        message:@"Please check your username and password and try again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

-(void) browseAsGuest:(id)sender{
    adcHomeViewController *home = [[adcHomeViewController alloc] init];
    [self.navigationController pushViewController:home animated:YES];

}



@end
