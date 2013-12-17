//
//  adcNavigationController.m
//  ADC
//
//  Created by Steve Ottenad on 12/12/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "adcNavigationController.h"

@interface adcNavigationController ()

@end

@implementation adcNavigationController

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
    NSLog(@"loading adcNav");
    self.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    UIBarButtonItem *cartButton = [[UIBarButtonItem alloc] initWithTitle:@"Show" style:UIBarButtonItemStylePlain target:self action:@selector(gotoCart)];
    viewController.navigationController.navigationItem.rightBarButtonItem = cartButton;
    NSLog(@"make cart");
}

-(void) gotoCart{
    NSLog(@"goto Cart");
    
}

@end
