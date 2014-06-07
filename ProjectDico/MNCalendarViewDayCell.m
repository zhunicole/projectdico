//
//  MNCalendarViewDayCell.m
//  ProjectDico
//
//  Created by Nicole Zhu on 6/02/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import "MNCalendarViewDayCell.h"

NSString *const MNCalendarViewDayCellIdentifier = @"MNCalendarViewDayCellIdentifier";

@interface MNCalendarViewDayCell()

@property(nonatomic,strong,readwrite) NSDate *date;
@property(nonatomic,strong,readwrite) NSDate *month;
@property(nonatomic,assign,readwrite) NSUInteger weekday;

@end

@implementation MNCalendarViewDayCell

- (void)setDate:(NSDate *)date
          month:(NSDate *)month
       calendar:(NSCalendar *)calendar {
    
    self.date     = date;
    self.month    = month;
    self.calendar = calendar;
    
    NSDateComponents *components =
    [self.calendar components:NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit
                     fromDate:self.date];
    
    NSDateComponents *monthComponents =
    [self.calendar components:NSMonthCalendarUnit
                     fromDate:self.month];
    
    self.weekday = components.weekday;
    self.titleLabel.text = [NSString stringWithFormat:@"%ld",(long)components.day];
    self.enabled = monthComponents.month == components.month;
    self.currentWeek = NO;
    
    [self setNeedsDisplay];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    self.titleLabel.textColor = self.enabled ? [UIColor whiteColor] : UIColor.lightGrayColor;
    
    self.backgroundColor =
    self.enabled ? [UIColor colorWithRed:256.0/255.0 green:182.0/255.0 blue:75.0/255.0 alpha:1.f] : [UIColor whiteColor];
    
}

- (void)setCurrentWeek:(BOOL)currentWeek{
    [super setCurrentWeek:currentWeek];
    
    
    if (self.currentWeek) {
        self.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:205.0/255.0 blue:139.0/255.0 alpha:1.f];

    }
    
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef separatorColor = self.separatorColor.CGColor;
    
    CGSize size = self.bounds.size;
    
    if (self.weekday != 7) {
        CGFloat pixel = 1.f / [UIScreen mainScreen].scale;
        MNContextDrawLine(context,
                          CGPointMake(size.width - pixel, pixel),
                          CGPointMake(size.width - pixel, size.height),
                          separatorColor,
                          pixel);
    }
}

@end
