//
//  CategoryTVC.m
//  ProjectDico
//
//  Created by Nicole Zhu on 5/24/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import "CategoryTVC.h"
#import "Constants.h"
#import "SubCategoryTVC.h"
#import <Parse/Parse.h>
#import "TaskCategory.h"

@interface CategoryTVC ()

@property (nonatomic, strong) NSArray *categoryArray;

@end

@implementation CategoryTVC

-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setCategoryArray];
}



#pragma mark - Table View
static const int kNumCategories = 7;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
//    return [sectionInfo numberOfObjects];
    return kNumCategories;

}

- (void) setCategoryArray {
    if (!_categoryArray) {
        PFQuery *query = [PFQuery queryWithClassName:@"task_categories"];
        
        // Follow relationship
        //    [postQuery whereKey:@"author" equalTo:[PFUser currentUser]];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                PFObject *entry = [objects objectAtIndex:([objects count]-1)];
                self.categoryArray = entry[@"list"];           // Store results
                [self.tableView reloadData];   // Reload table
            }
        }];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
    [cell.textLabel setText:[self.categoryArray objectAtIndex:indexPath.row]];
    return cell;
}




#pragma mark - Navigation

- (void)prepareVC:(SubcategoryTVC *)ivc
      forCategory:(NSInteger)catID
{
    ivc.categoryID = catID;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSInteger path = [[[self tableView] indexPathForSelectedRow] row];
    
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"pickSubcategory"]) {
                if ([segue.destinationViewController isKindOfClass:[SubcategoryTVC class]]) {
                    NSInteger categoryID = path;
                    [self prepareVC:segue.destinationViewController forCategory:categoryID];
                }
            }
        }
    }
}



- (IBAction)goToCategoryTVC :(UIStoryboardSegue*)segue {
    
}


@end
