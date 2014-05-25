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
    
    [self setupAppearance];  //TODO, if need to initialize view any more
    
    [self monitorReachability];
    
    self.welcomeViewController = [[WelcomeViewController alloc] init];
    
    
    [PFFacebookUtils initializeFacebook];

    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
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

#pragma mark - Facebook SDK

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[PFFacebookUtils session]];
}


//shouldn't need this it is deprecated
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[PFFacebookUtils session]];
//}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.

}



#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark - TODO methods to remove/replace

// Set up appearance parameters to achieve Anypic's custom look and feel
- (void)setupAppearance {
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    
//    NSShadow *shadow = [[NSShadow alloc] init];
//    shadow.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.750f];
//    shadow.shadowOffset = CGSizeMake(0.0f, 1.0f);
//    
//    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.498f green:0.388f blue:0.329f alpha:1.0f]];
//    [[UINavigationBar appearance] setTitleTextAttributes:@{
//                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
//                                                           NSShadowAttributeName: shadow
//                                                           }];
//    
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"BackgroundNavigationBar.png"]
//                                       forBarMetrics:UIBarMetricsDefault];
//    
//    [[UIButton appearanceWhenContainedIn:[UINavigationBar class], nil]
//     setTitleColor:[UIColor colorWithRed:214.0f/255.0f green:210.0f/255.0f blue:197.0f/255.0f alpha:1.0f]
//     forState:UIControlStateNormal];
//    
//    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
//                                                           NSForegroundColorAttributeName:
//                                                               [UIColor colorWithRed:214.0f/255.0f green:210.0f/255.0f blue:197.0f/255.0f alpha:1.0f],
//                                                           NSShadowAttributeName: shadow
//                                                           }
//                                                forState:UIControlStateNormal];
//    
//    [[UISearchBar appearance] setTintColor:[UIColor colorWithRed:32.0f/255.0f green:19.0f/255.0f blue:16.0f/255.0f alpha:1.0f]];
}

- (void) monitorReachability {
//    Reachability *hostReach = [Reachability reachabilityWithHostname:@"api.parse.com"];
//    
//    hostReach.reachableBlock = ^(Reachability*reach) {
//        _networkStatus = [reach currentReachabilityStatus];
//        
//        if ([self isParseReachable] && [PFUser currentUser] && self.MasterViewController.objects.count == 0) {
//            // Refresh home timeline on network restoration. Takes care of a freshly installed app that failed to load the main timeline under bad network conditions.
//            // In this case, they'd see the empty timeline placeholder and have no way of refreshing the timeline unless they followed someone.
//            [self.MasterViewController loadObjects];
//        }
//    };
//    
//    hostReach.unreachableBlock = ^(Reachability*reach) {
//        _networkStatus = [reach currentReachabilityStatus];
//    };
//    
//    [hostReach startNotifier];
}



@end
