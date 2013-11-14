//
//  adcMakeController.m
//  ADC
//
//  Created by Steve Ottenad on 11/11/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "adcMakeController.h"
#import "adcApiSessonManager.h"
#import "adcModelController.h"


@interface adcMakeController ()

@end

@implementation adcMakeController

@synthesize yearObj, makeTable;


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
    
    [makeTable setDelegate:self];
    [makeTable setDataSource:self];

    NSString *yearId = [yearObj valueForKey:@"id"];
    
    adcApiSessonManager *sessionManager = [adcApiSessonManager sharedManager];
    if(yearId !=nil){
        NSDictionary *params = @{@"id": yearId};
        
        [sessionManager POST:@"api/makes/" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
            myMakes = responseObject;
            [makeTable reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error: %@",error);
        }];
    }else{
        NSLog(@"Year id wasnt set");
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
    return myMakes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *row = [myMakes objectAtIndex:indexPath.row];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    title.text = [row valueForKey:@"name"];
    
    [title setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [cell addSubview:title];
    NSLog(@"%@", [row valueForKey:@"name"]);

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
    [makeTable deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *selectedRowIndex = [makeTable indexPathForSelectedRow];
    adcModelController *modelViewController = [segue destinationViewController];
    NSDictionary *row = [myMakes objectAtIndex:selectedRowIndex.row];
    
    modelViewController.yearObj = yearObj;
    modelViewController.makeObj = row;
}

@end
