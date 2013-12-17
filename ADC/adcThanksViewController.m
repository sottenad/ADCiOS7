//
//  adcThanksViewController.m
//  ADC
//
//  Created by Steve Ottenad on 12/17/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "adcThanksViewController.h"
#import "adcCoreDataHelper.h"

@interface adcThanksViewController ()

@end

@implementation adcThanksViewController

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
    adcCoreDataHelper *dataHelper = [adcCoreDataHelper alloc];
    [dataHelper clearCart];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
