//
//  adcProductDetailController.m
//  ADC
//
//  Created by Steve Ottenad on 11/13/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "adcProductDetailController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface adcProductDetailController ()

@end

@implementation adcProductDetailController
@synthesize productObj, categoryObj, mfgObj,
            lblTitle, lblPrice, btnAddToCart, txtProductText,
            imgMainImage;

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
    
    lblTitle.text = [productObj valueForKey:@"name"];
    lblPrice.text = [NSString stringWithFormat:@"$%@.00", [productObj valueForKey:@"price"]];
    txtProductText.text = [productObj valueForKey:@"description"];
    
    NSArray *imageArr = [productObj valueForKey:@"product_images"];
    if(imageArr.count > 0){
        NSDictionary *imageDict = [imageArr objectAtIndex:0];
        NSString *imageUrl = [imageDict valueForKey:@"image_url"];
        if(imageUrl != Nil){
            [imgMainImage setImageWithURL:[NSURL URLWithString:imageUrl]];
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addToCart:(id)sender{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Create a new managed object
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newProduct = [NSEntityDescription insertNewObjectForEntityForName:@"ProductInCart" inManagedObjectContext:context];
    NSData *productData = [NSKeyedArchiver archivedDataWithRootObject:productObj];
    
    [newProduct setValue:productData forKey:@"product"];
    
    NSString *vehicleName = [defaults valueForKey:@"selected_vehicle_name"];
    if(vehicleName!=nil){
        [newProduct setValue:vehicleName forKey:@"vehicleName"];
    }



    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }else{
        
    }

}

-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id mydelegate = [[UIApplication sharedApplication] delegate];
    if([mydelegate performSelector:@selector(managedObjectContext)]){
        context = [mydelegate managedObjectContext];
    }
    return context;
}

@end
