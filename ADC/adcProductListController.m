//
//  adcProductListController.m
//  ADC
//
//  Created by Steve Ottenad on 11/12/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "adcProductListController.h"
#import "adcUserHelper.h"
#import "adcApiSessonManager.h"
#import "adcProductDetailController.h"

@interface adcProductListController ()

@end

@implementation adcProductListController

@synthesize categoryObj, mfgObj, productCollection;


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

    [productCollection setDataSource:self];
    [productCollection setDelegate:self];
    
    NSString *vehicleId = [adcUserHelper getSelectedVehicleId];
    NSString *categoryId = [categoryObj valueForKey:@"id"];
    NSString *manufacturerId = [mfgObj valueForKey:@"id"];
    
    if(vehicleId!=nil){
        NSDictionary *params = @{@"carid":vehicleId, @"catid":categoryId, @"mfgid": manufacturerId };
        
        adcApiSessonManager *sessionManager = [adcApiSessonManager sharedManager];
        [sessionManager POST:@"api/getproductsbycarcatmfg/" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            myProducts = responseObject;
            [productCollection reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error: %@",error);
        }];
    }else{
        NSLog(@"Somehow you got here without a Vehicle ID or Category ID.");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    // Return the number of sections.
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return myProducts.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    NSDictionary *row = [myProducts objectAtIndex:indexPath.row];
    UILabel *title = (UILabel *)[cell viewWithTag:100];
    NSNumber *value = [row valueForKey:@"name"];
    NSString *year = [NSString stringWithFormat:@"%@",value];
    title.text = year;
    
    NSLog(@"%@", year);
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSArray *selectedRowIndexes = [productCollection indexPathsForSelectedItems];
    NSIndexPath *selectedRowIndex = [selectedRowIndexes firstObject];
    adcProductDetailController *productDetailController = [segue destinationViewController];
    NSDictionary *row = [myProducts objectAtIndex:selectedRowIndex.row];
    
    productDetailController.categoryObj = categoryObj;
    productDetailController.mfgObj = mfgObj;
    productDetailController.productObj = row;
}

@end
