//
//  UIBezierPath+Rob_dash.m
//  arrows
//
//  Created by Rob Mayoff on 9/30/14.
//  Copyright (c) 2014 Rob Mayoff. Public domain.
//

#import "UIBezierPath+Rob_dash.h"

@implementation UIBezierPath (Rob_dash)

- (instancetype)Rob_dashedPathWithPattern:(NSArray *)pattern phase:(CGFloat)phase {
    CGFloat lengths[pattern.count];
    size_t i = 0;
    for (NSNumber *number in pattern) {
        lengths[i++] = number.doubleValue;
    }
    CGPathRef dashedCGPath = CGPathCreateCopyByDashingPath(self.CGPath, NULL, phase, lengths, pattern.count);
    UIBezierPath *dashedPath = [self.class bezierPathWithCGPath:dashedCGPath];
    CGPathRelease(dashedCGPath);
    return dashedPath;
}

@end
