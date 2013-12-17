//
//  adcHomeViewController.m
//  ADC
//
//  Created by Steve Ottenad on 11/10/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "adcHomeViewController.h"
#import "adcUserHelper.h"
#import "adcSignInViewController.h"
#import "adcCoreDataHelper.h"

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
    UIImage *barBG = [UIImage imageNamed:@"top_bar_logo.png"];
    [self.navigationController.navigationBar setBackgroundImage:barBG forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.hidesBackButton = YES;
    
    defaultMessage = @"Welcome to the app";
    
    if(![adcUserHelper isUserLoggedIn]){
        adcSignInViewController *signin = [[UIStoryboard storyboardWithName:@"adc" bundle:nil] instantiateViewControllerWithIdentifier:@"signInView"];
        [self.navigationController pushViewController:signin animated:YES];
    }
    
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
    
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Remove Vehicle?"
                                                      message:@"Are you sure you want to remove this vehicle? Doing so will remove also all items from your cart."
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:nil];
    [message addButtonWithTitle:@"Remove"];
    [message show];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        adcCoreDataHelper *dataHelper = [adcCoreDataHelper alloc];
        NSManagedObjectContext *context = [dataHelper managedObjectContext];
        
        NSFetchRequest * allProducts = [[NSFetchRequest alloc] init];
        [allProducts setEntity:[NSEntityDescription entityForName:@"ProductInCart" inManagedObjectContext:context]];
        [allProducts setIncludesPropertyValues:NO]; //only fetch the managedObjectID
        
        NSError * error = nil;
        NSArray * products = [context executeFetchRequest:allProducts error:&error];
        //error handling goes here
        for (NSManagedObject * product in products) {
            [context deleteObject:product];
        }
        NSError *saveError = nil;
        [context save:&saveError];
        
        
        //Now Delete userdefault vehicle
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"selected_vehicle_name"];
        [defaults removeObjectForKey:@"make"];
        [defaults removeObjectForKey:@"model"];
        [defaults removeObjectForKey:@"model_id"];
        [defaults removeObjectForKey:@"year"];
        [self hideShowButtons];
        
    }
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
