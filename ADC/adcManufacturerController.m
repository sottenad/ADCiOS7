//
//  adcManufacturerController.m
//  ADC
//
//  Created by Steve Ottenad on 11/13/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "adcManufacturerController.h"
#import "adcUserHelper.h"
#import "adcApiSessonManager.h"
#import "adcProductListController.h"


@interface adcManufacturerController ()

@end

@implementation adcManufacturerController
@synthesize categoryObj;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    NSString *vehicleId = [adcUserHelper getSelectedVehicleId];
    NSString *categoryId = [categoryObj valueForKey:@"id"];
    
    if(vehicleId!=nil){
        NSDictionary *params = @{@"carid":vehicleId, @"catid":categoryId};
        
        adcApiSessonManager *sessionManager = [adcApiSessonManager sharedManager];
        [sessionManager POST:@"api/mfgByCarAndCat/" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@", responseObject);
            myMfgs = responseObject;
            [self.tableView reloadData];
            
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
    return myMfgs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *row = [myMfgs objectAtIndex:indexPath.row];
    UILabel *title = (UILabel *)[cell viewWithTag:100];
    NSNumber *value = [row valueForKey:@"name"];
    NSString *year = [NSString stringWithFormat:@"%@",value];
    title.text = year;
    
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
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
    adcProductListController *productViewController = [segue destinationViewController];
    NSDictionary *row = [myMfgs objectAtIndex:selectedRowIndex.row];
    
    productViewController.categoryObj = categoryObj;
    productViewController.mfgObj = row;
}

@end
