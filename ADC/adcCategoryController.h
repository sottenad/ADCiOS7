//
//  adcCategoryController.h
//  ADC
//
//  Created by Steve Ottenad on 11/12/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "adcBaseViewController.h"

@interface adcCategoryController : adcBaseViewController <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *myCategories;
}

@property IBOutlet UITableView *categoryTable;

@end
