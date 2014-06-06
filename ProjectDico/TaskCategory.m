//
//  TaskCategory.m
//  ProjectDico
//
//  Created by Nicole Zhu on 5/31/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import "TaskCategory.h"

@interface TaskCategory()

@property (strong, nonatomic) NSArray *categoriesArray;

@end


@implementation TaskCategory

@synthesize categoriesArray;



+ (void) uploadCategories {
    
    PFQuery *query = [PFQuery queryWithClassName:@"task_categories"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count]>0) {
            //do nothing
        } else {
            // Log details of the failure
            NSLog(@"Adding categories");
            PFObject *categories = [PFObject objectWithClassName:@"task_categories"];
            
            NSArray *array = @[@"Home Maintenance", @"Cleaning", @"Yard Work", @"Groceries", @"Pick-up And Delivery", @"Scheduling", @"Other"];
            
            categories[@"list"] = array;
            
            [categories saveInBackground];

        }
    }];
}

static const int kTotalCategories = 7;
+ (NSInteger) totalNumCategories {
    return kTotalCategories;
}
@end
