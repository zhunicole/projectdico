//
//  SubcategoryTVC.m
//  ProjectDico
//
//  Created by Nicole Zhu on 5/24/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import "SubcategoryTVC.h"
#import <Parse/Parse.h>
#import "DetailViewController.h"

@interface SubcategoryTVC()
@property (nonatomic, strong) NSArray *SubCategoryArray;
@end




@implementation SubcategoryTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setSubCategoryArray];
}



#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.SubCategoryArray.count;
    
}

- (void) setSubCategoryArray {
    if (!_SubCategoryArray) {
        PFQuery *query = [PFQuery queryWithClassName:@"task_subcategories"];
        [query whereKey:@"taskCategory" equalTo:[NSNumber numberWithInteger:self.categoryID]];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                PFObject *entry = [objects objectAtIndex:([objects count]-1)];
                self.SubCategoryArray = entry[@"list"];           // Store results
                [self.tableView reloadData];   // Reload table
            }
        }];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subcategory" forIndexPath:indexPath];
    [cell.textLabel setText:[self.SubCategoryArray objectAtIndex:indexPath.row]];
    return cell;
}




#pragma mark - Navigation

- (void)prepareVC:(DetailViewController *)ivc

{

    ivc.taskId = @"0";
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    int path = [[[self tableView] indexPathForSelectedRow] row];
    
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"showDetail"]) {
//                    NSInteger categoryID = path;
                [self prepareVC:segue.destinationViewController];

            }
        }
    }
}



@end
