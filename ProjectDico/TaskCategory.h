//
//  TaskCategory.h
//  ProjectDico
//
//  Created by Nicole Zhu on 5/31/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>


static const NSInteger kHomeMaintenance = 0;
static const NSInteger kCleaning = 1;
static const NSInteger kYardWork = 2;
static const NSInteger kGroceries = 3;
static const NSInteger kPickUpDelivery = 4;
static const NSInteger kScheduling = 5;
static const NSInteger kOther = 6;

@interface TaskCategory : NSObject

+ (void) uploadCategories;
+ (NSInteger) totalNumCategories;


@end
