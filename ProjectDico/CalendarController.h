//
//  CalendarController.h
//  ProjectDico
//
//  Created by Nicole Zhu on 6/3/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNCalendarHeaderView.h"
#import "MNCalendarView.h"


@interface CalendarController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>{
    
    IBOutlet UIPickerView *picker;
    NSArray *hourArray;
    NSArray *minuteArray;
    NSArray *AMPMArray;
}

@property (weak, nonatomic) IBOutlet UIView *calendarView;

@end



