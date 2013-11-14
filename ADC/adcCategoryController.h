//
//  adcCategoryController.h
//  ADC
//
//  Created by Steve Ottenad on 11/12/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface adcCategoryController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *myCategories;
}

@property IBOutlet UITableView *categoryTable;

@end
