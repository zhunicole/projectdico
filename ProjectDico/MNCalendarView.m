//
//  MNCalendarView.m
//  ProjectDico
//
//  Created by Nicole Zhu on 5/25/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//


#import "MNCalendarView.h"
#import "MNCalendarViewLayout.h"
#import "MNCalendarViewDayCell.h"
#import "MNCalendarViewWeekdayCell.h"
#import "MNCalendarHeaderView.h"
#import "MNFastDateEnumeration.h"
#import "NSDate+MNAdditions.h"

@interface MNCalendarView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic,strong,readwrite) UICollectionView *collectionView;
@property(nonatomic,strong,readwrite) UICollectionViewFlowLayout *layout;

@property(nonatomic,strong,readwrite) NSArray *monthDates;
@property(nonatomic,strong,readwrite) NSArray *weekdaySymbols;
@property(nonatomic,assign,readwrite) NSUInteger daysInWeek;

@property(nonatomic,strong,readwrite) NSDateFormatter *monthFormatter;

- (NSDate *)firstVisibleDateOfMonth:(NSDate *)date;
- (NSDate *)lastVisibleDateOfMonth:(NSDate *)date;

- (BOOL)dateEnabled:(NSDate *)date;
- (BOOL)currentWeek:(NSDate *)date;
- (BOOL)canSelectItemAtIndexPath:(NSIndexPath *)indexPath;



-(BOOL) isDate:(NSDate*)curDate LaterThanOrEqualTo:(NSDate*)date;
-(BOOL) isDate:(NSDate*)curDate EarlierThanOrEqualTo:(NSDate*)date;


- (void)applyConstraints;

@end

@implementation MNCalendarView

- (void)commonInit {
  self.calendar   = NSCalendar.currentCalendar;
  self.fromDate   = [NSDate.date mn_beginningOfDay:self.calendar];
  self.toDate     = [self.fromDate dateByAddingTimeInterval:MN_YEAR * 4];
  self.daysInWeek = 7;
  
  self.headerViewClass  = MNCalendarHeaderView.class;
  self.weekdayCellClass = MNCalendarViewWeekdayCell.class;
  self.dayCellClass     = MNCalendarViewDayCell.class;
  
  _separatorColor = [UIColor colorWithRed:.85f green:.85f blue:.85f alpha:1.f];
  
  [self addSubview:self.collectionView];
  [self applyConstraints];
  [self reloadData];
}

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self commonInit];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder: aDecoder];
  if ( self ) {
    [self commonInit];
  }
  
  return self;
}

- (UICollectionView *)collectionView {
  if (nil == _collectionView) {
    MNCalendarViewLayout *layout = [[MNCalendarViewLayout alloc] init];

    _collectionView =
      [[UICollectionView alloc] initWithFrame:CGRectZero
                         collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor colorWithRed:.96f green:.96f blue:.96f alpha:1.f];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [self registerUICollectionViewClasses];
  }
  return _collectionView;
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
  _separatorColor = separatorColor;
}

- (void)setCalendar:(NSCalendar *)calendar {
  _calendar = calendar;
  
  self.monthFormatter = [[NSDateFormatter alloc] init];
  self.monthFormatter.calendar = calendar;
  [self.monthFormatter setDateFormat:@"MMMM yyyy"];
}

- (void)setSelectedDate:(NSDate *)selectedDate {
  _selectedDate = [selectedDate mn_beginningOfDay:self.calendar];
}

- (void)reloadData {
  NSMutableArray *monthDates = @[].mutableCopy;
  MNFastDateEnumeration *enumeration =
    [[MNFastDateEnumeration alloc] initWithFromDate:[self.fromDate mn_firstDateOfMonth:self.calendar]
                                             toDate:[self.toDate mn_firstDateOfMonth:self.calendar]
                                           calendar:self.calendar
                                               unit:NSMonthCalendarUnit];
  for (NSDate *date in enumeration) {
    [monthDates addObject:date];
  }
  self.monthDates = monthDates;
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  formatter.calendar = self.calendar;
  
  self.weekdaySymbols = formatter.shortWeekdaySymbols;
  
  [self.collectionView reloadData];
}

- (void)registerUICollectionViewClasses {
  [_collectionView registerClass:self.dayCellClass
      forCellWithReuseIdentifier:MNCalendarViewDayCellIdentifier];
  
  [_collectionView registerClass:self.weekdayCellClass
      forCellWithReuseIdentifier:MNCalendarViewWeekdayCellIdentifier];
  
  [_collectionView registerClass:self.headerViewClass
      forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
             withReuseIdentifier:MNCalendarHeaderViewIdentifier];
}

- (NSDate *)firstVisibleDateOfMonth:(NSDate *)date {
  date = [date mn_firstDateOfMonth:self.calendar];
  
  NSDateComponents *components =
    [self.calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit
                fromDate:date];
  
  return
    [[date mn_dateWithDay:-((components.weekday - 1) % self.daysInWeek) calendar:self.calendar] dateByAddingTimeInterval:MN_DAY];
}

- (NSDate *)lastVisibleDateOfMonth:(NSDate *)date {
  date = [date mn_lastDateOfMonth:self.calendar];
  
  NSDateComponents *components =
    [self.calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit
                     fromDate:date];
  
  return
    [date mn_dateWithDay:components.day + (self.daysInWeek - 1) - ((components.weekday - 1) % self.daysInWeek)
                calendar:self.calendar];
}

- (void)applyConstraints {
  NSDictionary *views = @{@"collectionView" : self.collectionView};
  [self addConstraints:
   [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|"
                                           options:0
                                           metrics:nil
                                             views:views]];
  
  [self addConstraints:
   [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collectionView]|"
                                           options:0
                                           metrics:nil
                                             views:views]
   ];
}

- (BOOL)dateEnabled:(NSDate *)date {
  if (self.delegate && [self.delegate respondsToSelector:@selector(calendarView:shouldSelectDate:)]) {
    return [self.delegate calendarView:self shouldSelectDate:date];
  }
  return YES;
}

- (BOOL)currentWeek:(NSDate *)date {
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];// you can use your format.
    
    //Week Start Date
    
    NSCalendar *gregorian = [[NSCalendar alloc]        initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
    
    NSInteger dayofweek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:today] weekday];
    
    [components setDay:([components day] - ((dayofweek) - 1))];// for beginning of the week.
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateFormat_first = [[NSDateFormatter alloc] init];
    [dateFormat_first setDateFormat:@"yyyy-MM-dd"];
    
    //Week End Date
    NSCalendar *gregorianEnd = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *componentsEnd = [gregorianEnd components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
    
    NSInteger Enddayofweek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:today] weekday];
    
    [componentsEnd setDay:([componentsEnd day]+(7-Enddayofweek))];// for end day of the week
    
    NSDate *EndOfWeek = [gregorianEnd dateFromComponents:componentsEnd];
    NSDateFormatter *dateFormat_End = [[NSDateFormatter alloc] init];
    [dateFormat_End setDateFormat:@"yyyy-MM-dd"];
    
    if ([self isDate:date LaterThanOrEqualTo:beginningOfWeek] &&
        [self isDate:date EarlierThanOrEqualTo:EndOfWeek]) {
        return YES;
    } else {
        return NO;
    }
}


-(BOOL) isDate:(NSDate*)curDate LaterThanOrEqualTo:(NSDate*)date {
    return !([curDate compare:date] == NSOrderedAscending);
}

-(BOOL) isDate:(NSDate*)curDate EarlierThanOrEqualTo:(NSDate*)date {
    return !([curDate compare:date] == NSOrderedDescending);
}




- (BOOL)canSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  MNCalendarViewCell *cell = (MNCalendarViewCell *)[self collectionView:self.collectionView cellForItemAtIndexPath:indexPath];

  BOOL enabled = cell.enabled;

  if ([cell isKindOfClass:MNCalendarViewDayCell.class] && enabled) {
    MNCalendarViewDayCell *dayCell = (MNCalendarViewDayCell *)cell;

    enabled = [self dateEnabled:dayCell.date];
  }

  return enabled;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return self.monthDates.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
  MNCalendarHeaderView *headerView =
    [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                       withReuseIdentifier:MNCalendarHeaderViewIdentifier
                                              forIndexPath:indexPath];

  headerView.backgroundColor = self.collectionView.backgroundColor;
  headerView.titleLabel.text = [self.monthFormatter stringFromDate:self.monthDates[indexPath.section]];

  return headerView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  NSDate *monthDate = self.monthDates[section];
  
  NSDateComponents *components =
    [self.calendar components:NSDayCalendarUnit
                     fromDate:[self firstVisibleDateOfMonth:monthDate]
                       toDate:[self lastVisibleDateOfMonth:monthDate]
                      options:0];
  
  return self.daysInWeek + components.day + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {

  if (indexPath.item < self.daysInWeek) {
    MNCalendarViewWeekdayCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:MNCalendarViewWeekdayCellIdentifier
                                                forIndexPath:indexPath];
    
    cell.backgroundColor = self.collectionView.backgroundColor;
    cell.titleLabel.text = self.weekdaySymbols[indexPath.item];
    cell.separatorColor = self.separatorColor;
    return cell;
  }
  MNCalendarViewDayCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:MNCalendarViewDayCellIdentifier
                                              forIndexPath:indexPath];
  cell.separatorColor = self.separatorColor;
  
  NSDate *monthDate = self.monthDates[indexPath.section];
  NSDate *firstDateInMonth = [self firstVisibleDateOfMonth:monthDate];

  NSUInteger day = indexPath.item - self.daysInWeek;
  
  NSDateComponents *components =
    [self.calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit
                     fromDate:firstDateInMonth];
  components.day += day;
  
  NSDate *date = [self.calendar dateFromComponents:components];
  [cell setDate:date
          month:monthDate
       calendar:self.calendar];
  
  if (cell.enabled) {
    [cell setEnabled:[self dateEnabled:date]];
  }

    [cell setCurrentWeek:[self currentWeek:date]];


  if (self.selectedDate && cell.enabled) {
    [cell setSelected:[date isEqualToDate:self.selectedDate]];
  }
  
  return cell;
}

#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
  return [self canSelectItemAtIndexPath:indexPath];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  return [self canSelectItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {


    MNCalendarViewCell *cell = (MNCalendarViewCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];

  if ([cell isKindOfClass:MNCalendarViewDayCell.class] && cell.enabled) {
    MNCalendarViewDayCell *dayCell = (MNCalendarViewDayCell *)cell;
    
    self.selectedDate = dayCell.date;
      
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarView:didSelectDate:)]) {
      [self.delegate calendarView:self didSelectDate:dayCell.date];
    }
    
    [self.collectionView reloadData];
  }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  CGFloat width      = self.bounds.size.width;
  CGFloat itemWidth  = roundf(width / self.daysInWeek);
  CGFloat itemHeight = indexPath.item < self.daysInWeek ? 30.f : itemWidth;
  
  NSUInteger weekday = indexPath.item % self.daysInWeek;
  
  if (weekday == self.daysInWeek - 1) {
    itemWidth = width - (itemWidth * (self.daysInWeek - 1));
  }
  
  return CGSizeMake(itemWidth, itemHeight);
}

@end
