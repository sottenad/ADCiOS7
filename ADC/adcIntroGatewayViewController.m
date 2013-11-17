//
//  adcIntroGatewayViewController.m
//  ADC
//
//  Created by Steve Ottenad on 11/17/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "adcIntroGatewayViewController.h"
#import "adcUserHelper.h"
#import "adcHomeViewController.h"
#import "adcSignInViewController.h"

@interface adcIntroGatewayViewController ()

@end

@implementation adcIntroGatewayViewController

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
    if([adcUserHelper isUserLoggedIn]){
        [[UIStoryboard storyboardWithName:@"adc" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomVC"];
        adcHomeViewController *home = [adcHomeViewController alloc];
        [self.navigationController pushViewController:home animated:YES];
    }else{
        adcSignInViewController *signin = [adcSignInViewController alloc];
        [self.navigationController pushViewController:signin animated:YES];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
