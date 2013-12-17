//
//  adcCartViewController.m
//  ADC
//
//  Created by Steve Ottenad on 12/10/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "adcCartViewController.h"
#import "adcCoreDataHelper.h"

@interface adcCartViewController ()

@end

@implementation adcCartViewController

@synthesize cartTable, price;

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
	// Do any additional setup after loading the view.
    
    [cartTable setDelegate:self];
    [cartTable setDataSource:self];
    
    NSNumber *totalPrice = [NSNumber numberWithInt:0];
    
    arrayOfItems = [[NSMutableArray alloc] init];
    adcCoreDataHelper *dataHelper = [adcCoreDataHelper alloc];
    NSManagedObjectContext *context = [dataHelper managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ProductInCart"];
    NSArray *arr = [[context executeFetchRequest:fetchRequest error:nil]mutableCopy];
    for(int i = 0; i<arr.count; i++){
        NSManagedObject *productInCart = [arr objectAtIndex:i];
        NSData *mydata = [productInCart valueForKey:@"product"];
        NSDictionary *myDictionary = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:mydata];
        [arrayOfItems addObject:myDictionary];
        NSNumber *thisPrice = [myDictionary valueForKey:@"price"];
        totalPrice = [NSNumber numberWithInt:([totalPrice  intValue]+  [thisPrice intValue])] ;
        NSLog(@"%@", myDictionary);
    }
    [cartTable reloadData];

    price.text = [NSString stringWithFormat:@"$%@",totalPrice];
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
    return arrayOfItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *row = [arrayOfItems objectAtIndex:indexPath.row];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    NSNumber *value = [row valueForKey:@"name"];
    NSString *year = [NSString stringWithFormat:@"%@",value];
    title.text = year;
    
    
    [title setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [cell addSubview:title];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cartTable deselectRowAtIndexPath:indexPath animated:YES];
}



@end
