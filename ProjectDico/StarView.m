//
//  StarView.m
//  ProjectDico
//
//  Created by Nicole Zhu on 6/6/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import "StarView.h"



@interface StarView()
@end

@implementation StarView

#pragma mark - Drawing


- (UIBezierPath *)starShape:(CGRect)originalFrame
{
    
    CGFloat a = MIN(originalFrame.size.width, originalFrame.size.height);
    CGRect frame = CGRectMake(originalFrame.size.width/2 - a/2, originalFrame.size.height/2 - a/2, a, a);
    
//    CGRect frame = [self maximumSquareFrameThatFits:originalFrame];
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.05000 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67634 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30729 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.97553 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39549 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78532 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64271 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.79389 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95451 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.85000 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.20611 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95451 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21468 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64271 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.02447 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39549 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32366 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30729 * CGRectGetHeight(frame))];
    [bezierPath closePath];
    
    return bezierPath;
}

static const int kNumOfStars = 5;
- (UIBezierPath *)solidStars:(NSInteger)numSolid shapeInFrame:(CGRect)originalFrame
{
    CGFloat w = originalFrame.size.width/kNumOfStars;
    CGRect babyFrame = CGRectMake(0, 0, w, originalFrame.size.height);
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    for (int i=0; i < kNumOfStars; i++) {
        UIBezierPath* startPath = [self starShape:babyFrame];
        [startPath applyTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, i*w, 0)];
        [[UIColor whiteColor] setFill];
        if (i< numSolid)[startPath fill];
        [bezierPath appendPath:startPath];
    }
    
    return bezierPath;
}

- (void)drawRect:(CGRect)rect
{
        //basically put buttons over position of stars,
        //dep on button clicked, draw that array fo stars.

    UIBezierPath *starArray = [self solidStars:4 shapeInFrame:self.bounds];

    [[UIColor whiteColor]setStroke];
    [starArray stroke];
}




#pragma mark Initialization

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

@end

