//
//  UIBezierPath+Rob_forEach.h
//  arrows
//
//  Created by Rob Mayoff on 9/30/14.
//  Copyright (c) 2014 Rob Mayoff. Public domain.
//

#import <UIKit/UIKit.h>

typedef void (^Rob_UIBezierPath_moveBlock)(CGPoint destination);
typedef void (^Rob_UIBezierPath_lineBlock)(CGPoint destination);
typedef void (^Rob_UIBezierPath_quadBlock)(CGPoint control, CGPoint destination);
typedef void (^Rob_UIBezierPath_cubicBlock)(CGPoint control0, CGPoint control1, CGPoint destination);
typedef void (^Rob_UIBezierPath_closeBlock)(void);

@interface UIBezierPath (Rob_forEach)

- (void)Rob_forEachMove:(Rob_UIBezierPath_moveBlock)moveBlock line:(Rob_UIBezierPath_lineBlock)lineBlock quad:(Rob_UIBezierPath_quadBlock)quadBlock cubic:(Rob_UIBezierPath_cubicBlock)cubicBlock close:(Rob_UIBezierPath_closeBlock)closeBlock;

@end
