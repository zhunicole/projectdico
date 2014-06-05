//
//  MNCalendarViewCell.h
//  ProjectDico
//
//  Created by Nicole Zhu on 5/25/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import <UIKit/UIKit.h>

CG_EXTERN void MNContextDrawLine(CGContextRef c, CGPoint start, CGPoint end, CGColorRef color, CGFloat lineWidth);

@interface MNCalendarViewCell : UICollectionViewCell

@property(nonatomic,strong) NSCalendar *calendar;

@property(nonatomic,assign,getter = isEnabled) BOOL enabled;
@property(nonatomic, assign, getter = isCurrentWeek) BOOL currentWeek;

@property(nonatomic,strong) UIColor *separatorColor;

@property(nonatomic,strong,readonly) UILabel *titleLabel;

@end
