//
//  MasterViewController.h
//  ProjectDico
//
//  Created by Nicole Zhu on 5/24/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>


@interface MasterViewController : UIViewController <UITableViewDelegate , UITableViewDataSource>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
