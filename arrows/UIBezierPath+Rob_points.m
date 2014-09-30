//
//  UIBezierPath+Rob_points.m
//  arrows
//
//  Created by Rob Mayoff on 9/30/14.
//  Copyright (c) 2014 Rob Mayoff. Public domain.
//

#import "UIBezierPath+Rob_points.h"
#import "UIBezierPath+Rob_dash.h"
#import "UIBezierPath+Rob_forEach.h"
#import <tgmath.h>

static CGVector vectorFromPointToPoint(CGPoint tail, CGPoint head) {
    CGFloat length = hypot(head.x - tail.x, head.y - tail.y);
    return CGVectorMake((head.x - tail.x) / length, (head.y - tail.y) / length);
}

@implementation UIBezierPath (Rob_points)

- (void)Rob_forEachPointAtInterval:(CGFloat)interval perform:(void (^)(CGPoint, CGVector))block {
    UIBezierPath *dashedPath = [self Rob_dashedPathWithPattern:@[ @(interval * 0.5), @(interval * 0.5) ] phase:0];
    __block BOOL hasPendingSegment = NO;
    __block CGPoint pendingControlPoint;
    __block CGPoint pendingPoint;
    [dashedPath Rob_forEachMove:^(CGPoint destination) {
        if (hasPendingSegment) {
            block(pendingPoint, vectorFromPointToPoint(pendingControlPoint, pendingPoint));
            hasPendingSegment = NO;
        }
        pendingPoint = destination;
    } line:^(CGPoint destination) {
        pendingControlPoint = pendingPoint;
        pendingPoint = destination;
        hasPendingSegment = YES;
    } quad:^(CGPoint control, CGPoint destination) {
        pendingControlPoint = control;
        pendingPoint = destination;
        hasPendingSegment = YES;
    } cubic:^(CGPoint control0, CGPoint control1, CGPoint destination) {
        pendingControlPoint = control1;
        pendingPoint = destination;
        hasPendingSegment = YES;
    } close:nil];
    if (hasPendingSegment) {
        block(pendingPoint, vectorFromPointToPoint(pendingControlPoint, pendingPoint));
    }
}

@end
