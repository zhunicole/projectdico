//
//  SubCategory.h
//  ProjectDico
//
//  Created by Nicole Zhu on 6/1/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "TaskCategory.h"
@interface SubCategory : NSObject


+ (NSArray*) getSubcategoriesFor: (NSInteger )category;
+ (void) uploadSubCategories;
@end
