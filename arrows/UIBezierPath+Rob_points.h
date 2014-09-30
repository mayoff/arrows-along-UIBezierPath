//
//  UIBezierPath+Rob_points.h
//  arrows
//
//  Created by Rob Mayoff on 9/30/14.
//  Copyright (c) 2014 Rob Mayoff. Public domain.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (Rob_points)

- (void)Rob_forEachPointAtInterval:(CGFloat)interval perform:(void (^)(CGPoint point, CGVector vector))block;

@end
