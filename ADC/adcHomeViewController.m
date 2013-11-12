//
//  adcHomeViewController.m
//  ADC
//
//  Created by Steve Ottenad on 11/10/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "adcHomeViewController.h"

@interface adcHomeViewController ()

@end

@implementation adcHomeViewController

@synthesize lblUserGreeting, btnSignIn, btnLogOut;

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
    
    defaultMessage = @"Welcome to the app";
    
}

-(void) viewWillAppear:(BOOL)animated{
    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSObject *objUsername = [defaults objectForKey:@"username"];
    if(objUsername != nil){
        NSString *username = [defaults objectForKey:@"username"];
        lblUserGreeting.text = [[NSString alloc] initWithFormat:@"Welcome Back %@", username];
        btnSignIn.hidden = YES;
        btnLogOut.hidden = NO;
    }else{
        lblUserGreeting.text = defaultMessage;
        btnSignIn.hidden = NO;
        btnLogOut.hidden = YES;
    }
}

-(void)signOut:(id)sender
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    lblUserGreeting.text = defaultMessage;
    btnSignIn.hidden = NO;
    btnLogOut.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
