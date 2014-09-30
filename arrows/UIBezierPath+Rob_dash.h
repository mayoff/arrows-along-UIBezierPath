//
//  UIBezierPath+Rob_dash.h
//  arrows
//
//  Created by Rob Mayoff on 9/30/14.
//  Copyright (c) 2014 Rob Mayoff. Public domain.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (Rob_dash)

- (instancetype)Rob_dashedPathWithPattern:(NSArray *)pattern phase:(CGFloat)phase;

@end
