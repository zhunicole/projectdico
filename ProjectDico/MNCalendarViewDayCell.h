//
//  MNCalendarViewDayCell.h
//  ProjectDico
//
//  Created by Nicole Zhu on 5/25/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import "MNCalendarViewCell.h"

extern NSString *const MNCalendarViewDayCellIdentifier;

@interface MNCalendarViewDayCell : MNCalendarViewCell

@property(nonatomic,strong,readonly) NSDate *date;
@property(nonatomic,strong,readonly) NSDate *month;

- (void)setDate:(NSDate *)date
          month:(NSDate *)month
       calendar:(NSCalendar *)calendar;

@end
