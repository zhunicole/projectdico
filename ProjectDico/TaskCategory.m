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

//
//- (NSArray *) categoriesArray {
//    if (!_categoriesArray){
//        _categoriesArray = @[@"Home Maintenance", @"Cleaning", @"Yard Work", @"Groceries", @"Pick-up And Delivery", @"Scheduling", @"Other"];
//    }
//    return _categoriesArray;
//    
//}

+ (void) uploadCategories {
    
    PFQuery *query = [PFQuery queryWithClassName:@"task_categories"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count]>0) {
            // The find succeeded.
//            NSLog(@"Successfully retrieved %d objs.", objects.count);
            // Do something with the found objects
//            for (PFObject *object in objects) {
//                NSLog(@"%@", object.objectId);
//            }
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
/* Blocking call to retrieve categories of taks*/
//+ (void) getCategories {
////    PFQuery *query = [PFQuery queryWithClassName:@"task_categories"];
////    [query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
////    NSArray* categories = [query findObjects];
////    NSArray *categories;
//    
//    
//    
//    
//    PFQuery *query = [PFQuery queryWithClassName:@"task_categories"];
//    query.cachePolicy = kPFCachePolicyNetworkElseCache;
//    
//    [query whereKey:@"list" ]
//    
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            int numInArray = [objects count];
//            PFObject *obj = objects[numInArray-1];
//            NSArray* array = [obj objectForKey:@"list"];
//        } else {
//            // The network was inaccessible and we have no cached data for
//            // this query.
//        }
//    }];
//}


@end
