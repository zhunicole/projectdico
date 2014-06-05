//
//  MNCalendarWeekdayViewCell.m
//  ProjectDico
//
//  Created by Nicole Zhu on 5/25/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import "MNCalendarViewWeekdayCell.h"

NSString *const MNCalendarViewWeekdayCellIdentifier = @"MNCalendarViewWeekdayCellIdentifier";


@implementation MNCalendarViewWeekdayCell

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.titleLabel.font = [UIFont systemFontOfSize:12.f];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = [UIColor colorWithRed:256.0/255.0 green:182.0/255.0 blue:75.0/255.0 alpha:1.f];
    self.enabled = NO;
    
  }
  return self;
}

- (void)setWeekday:(NSUInteger)weekday {
  _weekday = weekday;
  
  [self setNeedsDisplay];
}

@end
