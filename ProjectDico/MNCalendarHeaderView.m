//
//  MNCalendarHeaderView.m
//  ProjectDico
//
//  Created by Nicole Zhu on 5/25/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import "MNCalendarHeaderView.h"

NSString *const MNCalendarHeaderViewIdentifier = @"MNCalendarHeaderViewIdentifier";

@interface MNCalendarHeaderView()

@property(nonatomic,strong,readwrite) UILabel *titleLabel;

@end

@implementation MNCalendarHeaderView

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.titleLabel.backgroundColor = [UIColor colorWithRed:256.0/255.0 green:182.0/255.0 blue:75.0/255.0 alpha:1.f];
    self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.titleLabel.font = [UIFont systemFontOfSize:18.f];
    self.titleLabel.textColor = [UIColor whiteColor];

    self.titleLabel.textAlignment = NSTextAlignmentCenter;

    [self addSubview:self.titleLabel];
  }
  return self;
}

- (void)setDate:(NSDate *)date {
  _date = date;

  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

  [dateFormatter setDateFormat:@"MMMM yyyy"];

  self.titleLabel.text = [dateFormatter stringFromDate:self.date];
}

@end
