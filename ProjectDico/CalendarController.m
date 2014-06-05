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
    NSLog(@"selected date: %@",calendarView.selectedDate);
}


-(void)viewDidLoad {
    
    [super viewDidLoad];
    hourArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];
    
    minuteArray = [[NSArray alloc] initWithObjects:@"00",@"10",@"20",@"30",@"40",@"50", nil];
    
    AMPMArray = [[NSArray alloc] initWithObjects:@"AM",@"PM", nil];
    
    
    CGAffineTransform t0 = CGAffineTransformMakeTranslation (0, picker.bounds.size.height/2);
    CGAffineTransform s0 = CGAffineTransformMakeScale       (1.0, 0.7);
    CGAffineTransform t1 = CGAffineTransformMakeTranslation (0, -picker.bounds.size.height/2);
    picker.transform = CGAffineTransformConcat          (t0, CGAffineTransformConcat(s0, t1));


    picker.delegate = self;

    
}


-(void)viewDidUnload {
    [super viewDidUnload];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    if (component == 0) {
        return [hourArray count];
    } else if (component==1) {
        return [minuteArray count];
    } else {
        return [AMPMArray count];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        NSString *selectedSTring = [hourArray objectAtIndex:row];
        NSLog(@"selected hour: %@", selectedSTring);
    } else if (component == 1) {
        NSString *selectedSTring = [minuteArray objectAtIndex:row];
        NSLog(@"selected hour: %@", selectedSTring);
    } else {
        NSString *selectedSTring = [AMPMArray objectAtIndex:row];
        NSLog(@"selected hour: %@", selectedSTring);

    }

}


// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        return [hourArray objectAtIndex:row];
    } else if (component == 1) {
        return [minuteArray objectAtIndex:row];
    } else {
        return [AMPMArray objectAtIndex:row];
    }
    
}


@end

