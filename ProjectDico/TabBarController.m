//
//  TabBarController.m
//  ProjectDico
//
//  Created by Nicole Zhu on 5/25/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//



#import "TabBarController.h"

@interface TabBarController ()
@property (nonatomic,strong) UINavigationController *navController;
@end

@implementation TabBarController
@synthesize navController;


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self tabBar] setBackgroundImage:[UIImage imageNamed:@"BackgroundTabBar.png"]];
    self.tabBar.tintColor = [UIColor colorWithRed:139.0f/255.0f green:111.0f/255.0f blue:95.0f/255.0f alpha:1.0f];
    
    self.navController = [[UINavigationController alloc] init];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
