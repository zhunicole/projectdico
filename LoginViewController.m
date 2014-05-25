//
//  LoginViewController.m
//  ProjectDico
//
//  Created by Nicole Zhu on 5/24/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import "LoginViewController.h"
#import "UserDetailsViewController.h"

@implementation LoginViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Facebook Profile";
    
    // Check if user is cached and linked to Facebook, if so, bypass login
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        [self.navigationController pushViewController:[[UserDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:NO];
    }
}


- (IBAction)loginButtonTouchHandler:(id)sender {
    //TODO edit login permissions accordingly
    NSArray *permissionsArray = @[@"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^ (PFUser *user, NSError *error) {
//        [_activityIndicator stopAnimating];
        if (!user) {
            if (!error) {
                NSLog(@"user canceled FB login");
            } else {
                NSLog(@"an error occurred with FB login");
            }
        } else if (user.isNew) {
            NSLog(@"User with FB signed up!");
            [self.navigationController pushViewController:[[UserDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
        } else {
            NSLog(@"User logged in");
            [self.navigationController pushViewController:[[UserDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
        }
    }];
    
}

@end
