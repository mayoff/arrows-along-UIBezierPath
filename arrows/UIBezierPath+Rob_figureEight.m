//
//  UIBezierPath+Rob_figureEight.m
//  arrows
//
//  Created by Rob Mayoff on 9/30/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import "UIBezierPath+Rob_figureEight.h"

@implementation UIBezierPath (Rob_figureEight)

+ (instancetype)Rob_figureEightInRect:(CGRect)rect {
    CGPoint const topCenter = CGPointMake(1, 1);
    CGPoint const bottomCenter = CGPointMake(1, 1 + 2 * M_SQRT2);
    UIBezierPath *path = [self bezierPath];
    [path addArcWithCenter:topCenter radius:1 startAngle:M_PI_4 endAngle:-M_PI - M_PI_4 clockwise:NO];
    [path addArcWithCenter:bottomCenter radius:1 startAngle:-M_PI_4 endAngle:M_PI + M_PI_4 clockwise:YES];
    [path closePath];
    [path applyTransform:CGAffineTransformMakeScale(rect.size.width / 2, rect.size.height / (2 + 2 * M_SQRT2))];
    [path applyTransform:CGAffineTransformMakeTranslation(rect.origin.x, rect.origin.y)];
    return path;
}

@end
