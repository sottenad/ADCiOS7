//
//  adcModelController.m
//  ADC
//
//  Created by Steve Ottenad on 11/11/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "adcModelController.h"
#import "adcApiSessonManager.h"

@interface adcModelController ()

@end

@implementation adcModelController

@synthesize makeObj, yearObj;

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

    NSString *yearId = [yearObj valueForKey:@"id"];
    NSString *makeId = [makeObj valueForKey:@"id"];
    
    adcApiSessonManager *sessionManager = [adcApiSessonManager sharedManager];
    if(makeId !=nil && yearId !=nil){
        NSDictionary *params = @{@"yearid": yearId, @"makeid": makeId};
        
        [sessionManager POST:@"api/carsByMakeAndYear/" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            myModels = responseObject;
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error: %@",error);
        }];
    }else{
        NSLog(@"Year or Make ID wasnt set");
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
    return myModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *row = [myModels objectAtIndex:indexPath.row];
    UILabel *title = (UILabel *)[cell viewWithTag:100];
    NSString *make = [row valueForKey:@"model"];
    title.text = make;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *selectedRow = [myModels objectAtIndex:indexPath.row];
    NSString *modelName = [selectedRow valueForKey:@"model"];
    NSString *makeName = [makeObj valueForKey:@"name"];
    NSString *yearName = [yearObj valueForKey:@"year"];
    NSString *vehicleName = [NSString stringWithFormat:@"%@ %@ %@",yearName, makeName, modelName];
    
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:vehicleName forKey:@"selected_vehicle_name"];
    //TODO: Figure out why the model object cannot save to NSdefaults
    //[defaults setObject:selectedRow forKey:@"model"];
    [defaults setObject:[selectedRow valueForKey:@"id"] forKey:@"model_id"];
    [defaults setObject:makeObj forKey:@"make"];
    [defaults setObject:yearObj forKey:@"year"];
    [defaults synchronize];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */


@end
