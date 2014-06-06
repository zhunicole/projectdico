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
    

    NSLog(@"end of this fn");
    return YES;
}

-(void) setDefaultStyles {

    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:80/255.0 green:188.0/255.0 blue:182.0/255.0 alpha:1.000]];


}

- (void)handlePush:(NSDictionary *)launchOptions {
    NSLog(@"annoying handle push function");
    // If the app was launched in response to a push notification, we'll handle the payload here
//    NSDictionary *remoteNotificationPayload = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//    if (remoteNotificationPayload) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:AppDelegateApplicationDidReceiveRemoteNotification object:nil userInfo:remoteNotificationPayload];
//        
//        if (![PFUser currentUser]) {
//            return;
//        }
//        
//        // If the push notification payload references a photo, we will attempt to push this view controller into view
//        NSString *photoObjectId = [remoteNotificationPayload objectForKey:kPAPPushPayloadPhotoObjectIdKey];
//        if (photoObjectId && photoObjectId.length > 0) {
//            [self shouldNavigateToPhoto:[PFObject objectWithoutDataWithClassName:kPAPPhotoClassKey objectId:photoObjectId]];
//            return;
//        }
//        
//        // If the push notification payload references a user, we will attempt to push their profile into view
//        NSString *fromObjectId = [remoteNotificationPayload objectForKey:kPAPPushPayloadFromUserObjectIdKey];
//        if (fromObjectId && fromObjectId.length > 0) {
//            PFQuery *query = [PFUser query];
//            query.cachePolicy = kPFCachePolicyCacheElseNetwork;
//            [query getObjectInBackgroundWithId:fromObjectId block:^(PFObject *user, NSError *error) {
//                if (!error) {
//                    UINavigationController *homeNavigationController = self.tabBarController.viewControllers[HomeTabBarItemIndex];
//                    self.tabBarController.selectedViewController = homeNavigationController;
//                    
//                    AccountViewController *accountViewController = [[AccountViewController alloc] initWithStyle:UITableViewStylePlain];
//                    accountViewController.user = (PFUser *)user;
//                    [homeNavigationController pushViewController:accountViewController animated:YES];
//                }
//            }];
//        }
//    }
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
    NSLog(@"presentLoginViewController");
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
//    [loginViewController setDelegate:self];
//    loginViewController.fields = PFLogInFieldsFacebook;
//    loginViewController.facebookPermissions = @[ @"user_about_me" ];
    
    [self.welcomeViewController presentViewController:loginViewController animated:NO completion:nil];
}

- (void)presentLoginViewController {
    [self presentLoginViewControllerAnimated:YES];
}

- (void)logOut {
    NSLog(@"logging out");
    // TODO clear cache
    [[Cache sharedCache] clear];
    
    // clear NSUserDefaults
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPAPUserDefaultsCacheFacebookFriendsKey];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPAPUserDefaultsActivityFeedViewControllerLastRefreshKey];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Unsubscribe from push notifications by removing the user association from the current installation.
//    [[PFInstallation currentInstallation] removeObjectForKey:kPAPInstallationUserKey];
//    [[PFInstallation currentInstallation] saveInBackground];
//    
//    // Clear all caches
    [PFQuery clearAllCachedResults];
    
    // Log out
    [PFUser logOut];
    
    // clear out cached data, view controllers, etc
    [self.navController popToRootViewControllerAnimated:NO];
    
    [self presentLoginViewController];
    
//    self.homeViewController = nil;
//    self.activityViewController = nil;
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
    NSLog(@"fbrequest did load");
    // This method is called twice - once for the user's /me profile, and a second time when obtaining their friends. We will try and handle both scenarios in a single method.
//    PFUser *user = [PFUser currentUser];
    
//    NSArray *data = [result objectForKey:@"data"];
    
//    if (data) {
//        // we have friends data
//        NSMutableArray *facebookIds = [[NSMutableArray alloc] initWithCapacity:[data count]];
//        for (NSDictionary *friendData in data) {
//            if (friendData[@"id"]) {
//                [facebookIds addObject:friendData[@"id"]];
//            }
//        }
//        
//        // cache friend data
//        [[Cache sharedCache] setFacebookFriends:facebookIds];
//        
//        if (user) {
//            if ([user objectForKey:kPAPUserFacebookFriendsKey]) {
//                [user removeObjectForKey:kPAPUserFacebookFriendsKey];
//            }
//            
//            if (![user objectForKey:kPAPUserAlreadyAutoFollowedFacebookFriendsKey]) {
//                self.hud.labelText = NSLocalizedString(@"Following Friends", nil);
//                firstLaunch = YES;
//                
//                [user setObject:@YES forKey:kPAPUserAlreadyAutoFollowedFacebookFriendsKey];
//                NSError *error = nil;
//                
//                // find common Facebook friends already using Anypic
//                PFQuery *facebookFriendsQuery = [PFUser query];
//                [facebookFriendsQuery whereKey:kPAPUserFacebookIDKey containedIn:facebookIds];
//                
//                // auto-follow Parse employees
//                PFQuery *parseEmployeesQuery = [PFUser query];
//                [parseEmployeesQuery whereKey:kPAPUserFacebookIDKey containedIn:kPAPParseEmployeeAccounts];
//                
//                // combined query
//                PFQuery *query = [PFQuery orQueryWithSubqueries:[NSArray arrayWithObjects:parseEmployeesQuery,facebookFriendsQuery, nil]];
//                
//                NSArray *anypicFriends = [query findObjects:&error];
//                
//                if (!error) {
//                    [anypicFriends enumerateObjectsUsingBlock:^(PFUser *newFriend, NSUInteger idx, BOOL *stop) {
//                        PFObject *joinActivity = [PFObject objectWithClassName:kPAPActivityClassKey];
//                        [joinActivity setObject:user forKey:kPAPActivityFromUserKey];
//                        [joinActivity setObject:newFriend forKey:kPAPActivityToUserKey];
//                        [joinActivity setObject:kPAPActivityTypeJoined forKey:kPAPActivityTypeKey];
//                        
//                        PFACL *joinACL = [PFACL ACL];
//                        [joinACL setPublicReadAccess:YES];
//                        joinActivity.ACL = joinACL;
//                        
//                        // make sure our join activity is always earlier than a follow
//                        [joinActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                            [PAPUtility followUserInBackground:newFriend block:^(BOOL succeeded, NSError *error) {
//                                // This block will be executed once for each friend that is followed.
//                                // We need to refresh the timeline when we are following at least a few friends
//                                // Use a timer to avoid refreshing innecessarily
//                                if (self.autoFollowTimer) {
//                                    [self.autoFollowTimer invalidate];
//                                }
//                                
//                                self.autoFollowTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(autoFollowTimerFired:) userInfo:nil repeats:NO];
//                            }];
//                        }];
//                    }];
//                }
//                
//                if (![self shouldProceedToMainInterface:user]) {
//                    [self logOut];
//                    return;
//                }
//                
//                if (!error) {
//                    [MBProgressHUD hideHUDForView:self.navController.presentedViewController.view animated:NO];
//                    if (anypicFriends.count > 0) {
//                        self.hud = [MBProgressHUD showHUDAddedTo:self.homeViewController.view animated:NO];
//                        self.hud.dimBackground = YES;
//                        self.hud.labelText = NSLocalizedString(@"Following Friends", nil);
//                    } else {
//                        [self.homeViewController loadObjects];
//                    }
//                }
//            }
//            
//            [user saveEventually];
//        } else {
//            NSLog(@"No user session found. Forcing logOut.");
//            [self logOut];
//        }
//    } else {
//        self.hud.labelText = NSLocalizedString(@"Creating Profile", nil);
//        
//        if (user) {
//            NSString *facebookName = result[@"name"];
//            if (facebookName && [facebookName length] != 0) {
//                [user setObject:facebookName forKey:kPAPUserDisplayNameKey];
//            } else {
//                [user setObject:@"Someone" forKey:kPAPUserDisplayNameKey];
//            }
//            
//            NSString *facebookId = result[@"id"];
//            if (facebookId && [facebookId length] != 0) {
//                [user setObject:facebookId forKey:kPAPUserFacebookIDKey];
//            }
//            
//            [user saveEventually];
//        }
//        
//        [FBRequestConnection startForMyFriendsWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//            if (!error) {
//                [self facebookRequestDidLoad:result];
//            } else {
//                [self facebookRequestDidFailWithError:error];
//            }
//        }];
//    }
}

- (void)facebookRequestDidFailWithError:(NSError *)error {
    NSLog(@"Facebook error: %@", error);
    
    if ([PFUser currentUser]) {
        if ([[error userInfo][@"error"][@"type"] isEqualToString:@"OAuthException"]) {
            NSLog(@"The Facebook token was invalidated. Logging out.");
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
    NSLog(@"monitoring reachability");

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
