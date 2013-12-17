//
//  adcBaseViewController.m
//  ADC
//
//  Created by Steve Ottenad on 12/17/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "adcBaseViewController.h"
#import "JSBadgeView.h"
#import "adcCoreDataHelper.h"
#import "adcCartViewController.h"


@interface adcBaseViewController ()

@end

@implementation adcBaseViewController

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

    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];

    button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *butImage = [UIImage imageNamed:@"cart@2x.png"];
    [button setBackgroundImage:butImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(gotoCart) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = backButton;
 
    
    //Find How Many
    adcCoreDataHelper *dataHelper = [adcCoreDataHelper alloc];
    context = [dataHelper managedObjectContext];
    fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ProductInCart"];
    badgeView = [[JSBadgeView alloc] initWithParentView:button alignment:JSBadgeViewAlignmentTopRight];
        [self calculateNumberInCart];
}

-(void)viewDidAppear:(BOOL)animated{
    [self calculateNumberInCart];
}


-(void)calculateNumberInCart{
    NSArray *arr = [[context executeFetchRequest:fetchRequest error:nil]mutableCopy];
    if(arr.count>0) {
        badgeView.hidden = NO;
        badgeView.badgeText = [NSString stringWithFormat:@"%i", arr.count ];
    }else{
        badgeView.hidden = YES;
    }
}

-(void) gotoCart{
    NSLog(@"goto Cart");

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"adc" bundle:[NSBundle mainBundle]];
    adcCartViewController *cartView = [storyboard instantiateViewControllerWithIdentifier:@"cartView"] ;
    [self.navigationController pushViewController:cartView animated:YES ];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
