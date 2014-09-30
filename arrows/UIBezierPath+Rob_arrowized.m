//
//  UIBezierPath+Rob_arrowized.m
//  arrows
//
//  Created by Rob Mayoff on 9/30/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import "UIBezierPath+Rob_arrowized.h"
#import "UIBezierPath+Rob_forEach.h"
#import <tgmath.h>

@implementation UIBezierPath (Rob_arrowized)

- (instancetype)Rob_arrowizedPathWithHeadLength:(CGFloat)length headAngleRadians:(CGFloat)radians {
    CGFloat sine = sin(radians);
    CGFloat cosine = cos(radians);

    __block BOOL controlPointIsValid = NO;
    __block CGPoint priorControlPoint;
    UIBezierPath *arrowizedPath = [UIBezierPath bezierPath];

    [self Rob_forEachMove:^(CGPoint destination) {
        if (controlPointIsValid) {
            controlPointIsValid = NO;
            [arrowizedPath Rob_addArrowHeadWithControlPoint:priorControlPoint length:length sine:sine cosine:cosine];
        }
        [arrowizedPath moveToPoint:destination];
    } line:^(CGPoint destination) {
        priorControlPoint = arrowizedPath.currentPoint;
        controlPointIsValid = YES;
        [arrowizedPath addLineToPoint:destination];
    } quad:^(CGPoint control, CGPoint destination) {
        priorControlPoint = control;
        controlPointIsValid = YES;
        [arrowizedPath addQuadCurveToPoint:destination controlPoint:control];
    } cubic:^(CGPoint control0, CGPoint control1, CGPoint destination) {
        priorControlPoint = control1;
        controlPointIsValid = YES;
        [arrowizedPath addCurveToPoint:destination controlPoint1:control0 controlPoint2:control1];
    } close:^{
        controlPointIsValid = NO;
        [arrowizedPath closePath];
    }];

    if (controlPointIsValid) {
        [arrowizedPath Rob_addArrowHeadWithControlPoint:priorControlPoint length:length sine:sine cosine:cosine];
    }

    return arrowizedPath;
}

- (void)Rob_addArrowHeadWithControlPoint:(CGPoint)controlPoint length:(CGFloat)length sine:(CGFloat)sine cosine:(CGFloat)cosine {
    CGPoint currentPoint = self.currentPoint;
    CGPoint vector = CGPointMake(controlPoint.x - currentPoint.x, controlPoint.y - currentPoint.y);
    CGFloat vLength = hypot(vector.x, vector.y);
    vector.x = length * vector.x / vLength;
    vector.y = length * vector.y / vLength;

    CGPoint p;
    p.x = currentPoint.x + (cosine * vector.x +  -sine * vector.y);
    p.y = currentPoint.y + (  sine * vector.x + cosine * vector.y);
    [self addLineToPoint:p];
    [self moveToPoint:currentPoint];

    p.x = currentPoint.x + (cosine * vector.x +   sine * vector.y);
    p.y = currentPoint.y + ( -sine * vector.x + cosine * vector.y);
    [self addLineToPoint:p];

    // Don't need to restore current point because I'm only called before moveToPoint or at the end of the path.
}

@end
