//
//  TypeDetailsViewController.m
//  ProjectDico
//
//  Created by Nicole Zhu on 6/5/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import "TypeDetailsViewController.h"

@implementation TypeDetailsViewController

-(void)viewDidLoad{
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];

}




-(void)hideKeyBoard {
    [taskDetailTextField resignFirstResponder];
    
}

@end
