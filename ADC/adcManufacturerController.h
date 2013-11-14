//
//  adcManufacturerController.h
//  ADC
//
//  Created by Steve Ottenad on 11/13/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface adcManufacturerController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *myMfgs;
}

@property IBOutlet UITableView *mfgTable;

@property NSDictionary *categoryObj;

@end
