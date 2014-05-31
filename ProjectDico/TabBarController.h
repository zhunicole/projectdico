//
//  TabBarController.h
//  ProjectDico
//
//  Created by Nicole Zhu on 5/25/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.


//#import "EditPhotoViewController.h"

@protocol TabBarControllerDelegate;

@interface TabBarController : UITabBarController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

//- (BOOL)shouldPresentPhotoCaptureController;

@end

@protocol TabBarControllerDelegate <NSObject>

//- (void)tabBarController:(UITabBarController *)tabBarController cameraButtonTouchUpInsideAction:(UIButton *)button;

@end