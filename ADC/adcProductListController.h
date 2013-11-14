//
//  adcProductListController.h
//  ADC
//
//  Created by Steve Ottenad on 11/12/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface adcProductListController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>{
    NSMutableArray *myProducts;
}

@property IBOutlet UICollectionView *productCollection;

@property NSDictionary *mfgObj;
@property NSDictionary *categoryObj;

@end
