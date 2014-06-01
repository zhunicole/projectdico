//
//  CategoryTVC.m
//  ProjectDico
//
//  Created by Nicole Zhu on 5/24/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import "CategoryTVC.h"
#import <Parse/Parse.h>

@interface CategoryTVC ()

@property (nonatomic, strong) NSArray *categoryArray;

@end

@implementation CategoryTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setCategoryArray];
}



#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
//    return [sectionInfo numberOfObjects];
    return 7;
}

- (void) setCategoryArray {
//    if (!_categoryArray) {
        NSLog(@"ehre");
        PFQuery *query = [PFQuery queryWithClassName:@"task_categories"];
        
        // Follow relationship
        //    [postQuery whereKey:@"author" equalTo:[PFUser currentUser]];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                PFObject *entry = [objects objectAtIndex:([objects count]-1)];
                self.categoryArray = entry[@"list"];           // Store results
                NSLog(@"task cat: %@", [self.categoryArray objectAtIndex:0]);
                [self.tableView reloadData];   // Reload table
            }
        }];

//    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];

//    PFObject *category = [self.categoryArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:[self.categoryArray objectAtIndex:indexPath.row]];
    return cell;
}

- (IBAction)goToCategoryTVC :(UIStoryboardSegue*)segue {
    
}

@end
