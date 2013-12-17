//
//  adcYearController.h
//  ADC
//
//  Created by Steve Ottenad on 11/11/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "adcBaseViewController.h"

@interface adcYearController : adcBaseViewController <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *myYears;
}

@property IBOutlet UITableView *yearTable;


@end
