//
//  adcCategoryController.m
//  ADC
//
//  Created by Steve Ottenad on 11/12/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "adcCategoryController.h"
#import "adcApiSessonManager.h"
#import "adcUserHelper.h"
#import "adcProductListController.h"

@interface adcCategoryController ()

@end

@implementation adcCategoryController

@synthesize categoryTable;

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
    
    [categoryTable setDelegate:self];
    [categoryTable setDataSource:self];

    NSString *vehicleId = [adcUserHelper getSelectedVehicleId];
    
    if(vehicleId!=nil){
        NSDictionary *params = @{@"id":vehicleId};
        
        adcApiSessonManager *sessionManager = [adcApiSessonManager sharedManager];
        [sessionManager POST:@"api/categories/" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            myCategories = responseObject;
            [categoryTable reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error: %@",error);
        }];
    }else{
        NSLog(@"Somehow you got here without a vehicle id.");
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return myCategories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *row = [myCategories objectAtIndex:indexPath.row];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    NSNumber *value = [row valueForKey:@"name"];
    NSString *year = [NSString stringWithFormat:@"%@",value];
    title.text = year;
    
    
    [title setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [cell addSubview:title];
    
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [categoryTable deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *selectedRowIndex = [categoryTable indexPathForSelectedRow];
    adcProductListController *productViewController = [segue destinationViewController];
    NSDictionary *row = [myCategories objectAtIndex:selectedRowIndex.row];
    
    productViewController.categoryObj = row;

}

@end
