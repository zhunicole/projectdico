//
//  ConfirmBookingController.m
//  ProjectDico
//
//  Created by Nicole Zhu on 6/6/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import "Parse/Parse.h"
#import "ConfirmBookingController.h"
#import "DetailViewController.h"

@implementation ConfirmBookingController


-(void)viewDidLoad{
    
    
    //save new booking to db, updates the progress of task item in DB
    
    [super viewDidLoad];
    PFQuery *query = [PFQuery queryWithClassName:@"tasks"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSNumber *number = object[@"progress"];
                int value = [number intValue];
                NSNumber *newProgress = [NSNumber numberWithInt:value + 1];
                
                PFObject *newTask = [PFObject objectWithClassName:@"tasks"];
                newTask[@"taskTitle"] = object[@"taskTitle"];
                newTask[@"progress"] = newProgress;
                [newTask saveInBackground];
                
            }
            
        } else {
            NSLog(@"Parse error");
        }
    }];
}


@end
