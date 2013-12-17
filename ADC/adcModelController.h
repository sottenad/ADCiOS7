//
//  adcModelController.h
//  ADC
//
//  Created by Steve Ottenad on 11/11/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "adcBaseViewController.h"

@interface adcModelController : adcBaseViewController <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *myModels;
    NSDictionary *mySelectedModel;
}

@property IBOutlet UITableView *modelTable;

@property NSDictionary *yearObj;
@property NSDictionary *makeObj;


@end
