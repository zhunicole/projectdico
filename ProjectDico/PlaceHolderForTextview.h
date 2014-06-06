//
//  PlaceHolderForTextview.h
//  ProjectDico
//
//  Created by Nicole Zhu on 6/5/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//
// courtesy of Stackoverflow


#import <Foundation/Foundation.h>
@interface PlaceHolderForTextview : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end