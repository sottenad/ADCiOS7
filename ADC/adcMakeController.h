//
//  adcMakeController.h
//  ADC
//
//  Created by Steve Ottenad on 11/11/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "adcBaseViewController.h"

@interface adcMakeController : adcBaseViewController <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *myMakes;
}

@property IBOutlet UITableView *makeTable;

@property NSDictionary *yearObj;


@end
