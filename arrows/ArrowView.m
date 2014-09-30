//
//  ArrowView.m
//  arrows
//
//  Created by Rob Mayoff on 9/30/14.
//  Copyright (c) 2014 Rob Mayoff. Public domain.
//

#import "ArrowView.h"
#import "UIBezierPath+Rob_figureEight.h"
#import "UIBezierPath+Rob_points.h"

@implementation ArrowView

- (void)setInterval:(CGFloat)interval {
    _interval = interval;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    UIImage *arrow = [UIImage imageNamed:@"right233.png"];
    UIBezierPath *path = [UIBezierPath Rob_figureEightInRect:CGRectInset(self.bounds, 40, 40)];
//    [path stroke];
    [path Rob_forEachPointAtInterval:self.interval perform:^(CGPoint point, CGVector vector) {
        CGContextRef gc = UIGraphicsGetCurrentContext();
        CGContextSaveGState(gc); {
            CGContextTranslateCTM(gc, point.x, point.y);
            CGContextConcatCTM(gc, CGAffineTransformMake(vector.dx, vector.dy, -vector.dy, vector.dx, 0, 0));
            CGContextTranslateCTM(gc, -0.5 * arrow.size.width, -0.5 * arrow.size.height);
//            UIRectFrame((CGRect){ CGPointZero, arrow.size });
            [arrow drawAtPoint:CGPointZero];
        } CGContextRestoreGState(gc);
    }];
}

@end
