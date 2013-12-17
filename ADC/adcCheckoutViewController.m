//
//  adcCheckoutViewController.m
//  ADC
//
//  Created by Steve Ottenad on 12/16/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "adcCheckoutViewController.h"
#import "adcCoreDataHelper.h"
#import "adcUserHelper.h"
#import "adcApiSessonManager.h"

@interface adcCheckoutViewController ()

@end

@implementation adcCheckoutViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendOrder:(id)sender{
    NSLog(@"sending order");
    NSMutableArray *arrayOfItems = [[NSMutableArray alloc] init];
    adcCoreDataHelper *dataHelper = [adcCoreDataHelper alloc];
    NSManagedObjectContext *context = [dataHelper managedObjectContext];
    NSDictionary *myDictionary;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ProductInCart"];
    NSArray *arr = [[context executeFetchRequest:fetchRequest error:nil]mutableCopy];
    for(int i = 0; i<arr.count; i++){
        NSManagedObject *productInCart = [arr objectAtIndex:i];
        NSData *mydata = [productInCart valueForKey:@"product"];
        myDictionary = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:mydata];
        NSNumber *thisId = [myDictionary valueForKey:@"id"];
        [arrayOfItems addObject:thisId];
        NSLog(@"%@",myDictionary);
    }
    
    NSString *vehicleId = [adcUserHelper getSelectedVehicleId];
    NSString *productIds = [arrayOfItems componentsJoinedByString:@","];
    
    if(vehicleId!=nil){
        NSDictionary *params = @{@"order": @{@"vehicle_id":vehicleId, @"product_ids": productIds}};
        
        adcApiSessonManager *sessionManager = [adcApiSessonManager sharedManager];
        [sessionManager POST:@"orders.json/" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {

            NSLog(@"%@",responseObject);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error: %@",error);
        }];
    }else{
        NSLog(@"Somehow you got here without a vehicle id.");
    }


    
}


@end
