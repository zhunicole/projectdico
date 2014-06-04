//
//  CalendarController.m
//  ProjectDico
//
//  Created by Nicole Zhu on 6/3/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import "CalendarController.h"


@implementation CalendarController

- (void) viewDidAppear:(BOOL)animated {
    NSLog(@"here");
    MNCalendarView *calendarView = [[MNCalendarView alloc] initWithFrame:self.view.bounds];
    calendarView.selectedDate = [NSDate date];
    calendarView.delegate = self;
}


@end
