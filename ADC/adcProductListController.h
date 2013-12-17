//
//  adcProductListController.h
//  ADC
//
//  Created by Steve Ottenad on 11/12/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "adcBaseViewController.h"

@interface adcProductListController : adcBaseViewController <UICollectionViewDataSource, UICollectionViewDelegate>{
    NSMutableArray *myProducts;
}

@property IBOutlet UICollectionView *productCollection;

@property NSDictionary *mfgObj;
@property NSDictionary *categoryObj;

@end
