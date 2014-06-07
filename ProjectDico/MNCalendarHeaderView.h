//
//  MNCalendarHeaderView.h
//  ProjectDico
//
//  Created by Nicole Zhu on 6/02/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const MNCalendarHeaderViewIdentifier;

@interface MNCalendarHeaderView : UICollectionReusableView

@property(nonatomic,strong,readonly) UILabel *titleLabel;
@property(nonatomic,strong) NSDate *date;

@end
