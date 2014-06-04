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
    MNCalendarView *calendarView = [[MNCalendarView alloc] initWithFrame:self.view.bounds];
    calendarView.selectedDate = [NSDate date];
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow: -(60.0f*60.0f*24.0f)];
    calendarView.selectedDate = yesterday;

//    calendarView.delegate = self; not sure what this does
    
    NSLog(@"selected date: %@",calendarView.selectedDate);
}


@end
