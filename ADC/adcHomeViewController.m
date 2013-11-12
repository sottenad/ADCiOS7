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

@synthesize lblUserGreeting, btnSignIn, btnLogOut,
            lblSelectedVehicle, btnSelectVehicle, btnClearSelectedVehicle,
            btnViewCatalog;

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
    [self hideShowButtons];
}


-(void)signOut:(id)sender
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    lblUserGreeting.text = defaultMessage;
    btnSignIn.hidden = NO;
    btnLogOut.hidden = YES;
}

-(void)clearSelectedVehicle:(id)sender{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"selected_vehicle_name"];
    [defaults removeObjectForKey:@"make"];
    [defaults removeObjectForKey:@"model"];
    [defaults removeObjectForKey:@"model_id"];
    [defaults removeObjectForKey:@"year"];
    [self hideShowButtons];
    
}

-(void) hideShowButtons{
    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //Handle Login display
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
    
    //Handle selected vehicle display
    NSString *vehicleName = [defaults valueForKey:@"selected_vehicle_name"];
    if(vehicleName!=nil){
        lblSelectedVehicle.hidden = NO;
        lblSelectedVehicle.text = vehicleName;
        btnSelectVehicle.hidden = YES;
        btnClearSelectedVehicle.hidden = NO;
        btnViewCatalog.hidden = NO;
    }else{
        lblSelectedVehicle.text = @"";
        lblSelectedVehicle.hidden = YES;
        btnSelectVehicle.hidden = NO;
        btnClearSelectedVehicle.hidden = YES;
        btnViewCatalog.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
