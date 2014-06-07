//
//  AppDelegate.m
//  ProjectDico
//
//  Created by Nicole Zhu on 5/24/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import <Parse/Parse.h>
#import "Reachability.h"
#import "AppDelegate.h"
#import "MasterViewController.h"
#import "LoginViewController.h"
#import "WelcomeViewController.h"
#import "Cache.h"

@interface AppDelegate ()

@property (nonatomic, strong) WelcomeViewController *welcomeViewController;

@property (nonatomic, strong) NSTimer *autoFollowTimer;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"MCMwZBT970NiCf0DWZnY6vTSAie6yWzL0uX1LJqY"
                  clientKey:@"XMSccs2XzqjtOHbYvOsjZhPvzBhua9nDSZEZjRkr"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    if (application.applicationIconBadgeNumber !=0) {
        application.applicationIconBadgeNumber = 0;
        [[PFInstallation currentInstallation] saveInBackground]; //saves async in background
    }
    
    PFACL *defaultACL = [PFACL ACL]; //read/write permissions to spec users
    [defaultACL setPublicReadAccess:YES]; //public read access by default
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    [self setDefaultStyles];
//    [self monitorReachability];
    
    [PFFacebookUtils initializeFacebook];
    
    return YES;
}

-(void) setDefaultStyles {

    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:80/255.0 green:188.0/255.0 blue:182.0/255.0 alpha:1.000]];

    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
    
    [[UIToolbar appearance] setBarTintColor:[UIColor colorWithRed:80/255.0 green:188.0/255.0 blue:182.0/255.0 alpha:1.000]];


    
}

- (void)handlePush:(NSDictionary *)launchOptions {

}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    
    // Clear badge and update installation, required for auto-incrementing badges.
    if (application.applicationIconBadgeNumber != 0) {
        application.applicationIconBadgeNumber = 0;
        [[PFInstallation currentInstallation] saveInBackground];
    }
    
    // Clears out all notifications from Notification Center.
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    application.applicationIconBadgeNumber = 1;
    application.applicationIconBadgeNumber = 0;
    

    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


#pragma mark - AppDelegate

- (BOOL)isParseReachable {
    return self.networkStatus != NotReachable;
}



- (void)presentLoginViewControllerAnimated:(BOOL)animated {
    LoginViewController *loginViewController = [[LoginViewController alloc] init];

    
    [self.welcomeViewController presentViewController:loginViewController animated:NO completion:nil];
}

- (void)presentLoginViewController {
    [self presentLoginViewControllerAnimated:YES];
}

- (void)logOut {

    [[Cache sharedCache] clear];
    [PFQuery clearAllCachedResults];
    
    // Log out
    [PFUser logOut];
    
    // clear out cached data, view controllers, etc
    [self.navController popToRootViewControllerAnimated:NO];
    
    [self presentLoginViewController];
    
}


#pragma mark - Facebook SDK

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[PFFacebookUtils session]];
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.

}


- (void)facebookRequestDidLoad:(id)result {

}

- (void)facebookRequestDidFailWithError:(NSError *)error {
    
    if ([PFUser currentUser]) {
        if ([[error userInfo][@"error"][@"type"] isEqualToString:@"OAuthException"]) {
            [self logOut];
        }
    }
}



#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark - TODO methods to remove/replace


- (void) monitorReachability {

}



@end
