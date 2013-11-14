//
//  adcProductDetailController.m
//  ADC
//
//  Created by Steve Ottenad on 11/13/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "adcProductDetailController.h"

@interface adcProductDetailController ()

@end

@implementation adcProductDetailController
@synthesize productObj, categoryObj, mfgObj,
            lblTitle, lblPrice, btnAddToCart, txtProductText;

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
