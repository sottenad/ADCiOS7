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
    
    UIImage *barBG = [[UIImage alloc] initWithContentsOfFile:@"top_bar.png"];
    [self.navigationController.navigationBar setBackgroundImage:barBG forBarMetrics:UIBarMetricsDefault];
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
    
    [sessionMgr GET:@"token/gettoken" parameters:options success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"response:%@", responseObject);
        NSDictionary *respDict = responseObject;
        
        int success = [[respDict valueForKey:@"success"] integerValue];

        if(success == 1){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:[respDict valueForKey:@"auth_token"] forKey:@"auth_token"];
            [defaults setInteger: (int)[respDict valueForKey:@"price_multiplier"] forKey:@"price_multiplier"];
            [defaults setObject:[respDict valueForKey:@"username"] forKey:@"username"];
            [defaults synchronize];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        adcHomeViewController *home = [[adcHomeViewController alloc] init];
        [self.navigationController pushViewController:home animated:YES];
        
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
