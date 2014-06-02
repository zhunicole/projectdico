//
//  SubCategory.m
//  ProjectDico
//
//  Created by Nicole Zhu on 6/1/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import "SubCategory.h"


static NSArray *homeMaintenance;
static NSArray *cleaning;
static NSArray *yardWork;
static NSArray *groceries;
static NSArray *pickUpDelivery;
static NSArray *scheduling;
static NSArray *other;

@implementation SubCategory


+ (void)initialize {
    homeMaintenance = @[
                  @"Furniture",
                  @"Painting",
                  @"Won Games",
                  @"Lost Games",
                  @"Options"
                  ];
    cleaning = @[
                        @"Your Move",
                        @"Their Move",
                        @"Won Games",
                        @"Lost Games",
                        @"Options"
                        ];
    yardWork = @[
                        @"Your Move",
                        @"Their Move",
                        @"Won Games",
                        @"Lost Games",
                        @"Options"
                        ];
    groceries = @[
                        @"Your Move",
                        @"Their Move",
                        @"Won Games",
                        @"Lost Games",
                        @"Options"
                        ];
    pickUpDelivery = @[
                        @"Your Move",
                        @"Their Move",
                        @"Won Games",
                        @"Lost Games",
                        @"Options"
                        ];
    scheduling = @[
                        @"Your Move",
                        @"Their Move",
                        @"Won Games",
                        @"Lost Games",
                        @"Options"
                        ];
    other = @[
                   @"Your Move",
                   @"Their Move",
                   @"Won Games",
                   @"Lost Games",
                   @"Options"
                   ];
    
    
}

+ (NSArray*) getSubcategoriesFor: (NSInteger)category {
    
    switch (category)
    
    {
        case 0:
            
            return homeMaintenance;
            
            break;
            
        case 1:
            
            return cleaning;
            
            break;
        case 2:
            
            return yardWork;
            
            break;
        case 3:
            
            return groceries;
            
            break;
        case 4:
            
            return pickUpDelivery;
            
            break;
        case 5:
            
            return scheduling;
            
            break;

        default:
            
            return other;
            
            break;
            
    }
    
    
}

+ (void) loadSubCategories {
    NSLog(@"loading subcategories");
    
    PFQuery *query = [PFQuery queryWithClassName:@"task_subcategories"];
    [query whereKey:@"taskCategory" equalTo:[NSNumber numberWithInteger:0]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count]>0) { //has a list for that specific
            NSLog(@"Successfully retrieved %d objs.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Adding homemaintenace subcategory");
            PFObject *subcategories = [PFObject objectWithClassName:@"task_subcategories"];
            subcategories[@"taskCategory"] = [NSNumber numberWithInteger:0];
            subcategories[@"list"] = [self getSubcategoriesFor:0];
            [subcategories saveInBackground];
            
        }
    }];
}

//- (void) loadSubCategoriesFor: (NSInteger)category {
//    
//    PFQuery *query = [PFQuery queryWithClassName:@"task_subcategories"];
//    [query whereKey:@"taskCategory" equalTo:[NSNumber numberWithInteger:category]];
//     
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) { //has a list for that specific
//            NSLog(@"Successfully retrieved %d objs.", objects.count);
//            // Do something with the found objects
//            for (PFObject *object in objects) {
//                NSLog(@"%@", object.objectId);
//            }
//        } else {
//            // Log details of the failure
//            NSLog(@"Adding sub categories");
//            PFObject *subcategories = [PFObject objectWithClassName:@"task_subcategories"];
//            subcategories[@"taskCategory"] = [NSNumber numberWithInteger:category];
//            subcategories[@"list"] = [self getSubcategoriesFor:category];
//            [subcategories saveInBackground];
//            
//        }
//    }];
//}

@end
