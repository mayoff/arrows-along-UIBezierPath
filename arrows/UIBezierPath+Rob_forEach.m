//
//  UIBezierPath+Rob_forEach.m
//  arrows
//
//  Created by Rob Mayoff on 9/30/14.
//  Copyright (c) 2014 Rob Mayoff. Public domain.
//

#import "UIBezierPath+Rob_forEach.h"

struct ForEachBlocks {
    __unsafe_unretained Rob_UIBezierPath_moveBlock moveBlock;
    __unsafe_unretained Rob_UIBezierPath_lineBlock lineBlock;
    __unsafe_unretained Rob_UIBezierPath_quadBlock quadBlock;
    __unsafe_unretained Rob_UIBezierPath_cubicBlock cubicBlock;
    __unsafe_unretained Rob_UIBezierPath_closeBlock closeBlock;
};

static void applyBlockToPathElement(void *info, const CGPathElement *element) {
    struct ForEachBlocks *blocks = info;
    switch (element->type) {
        case kCGPathElementMoveToPoint:
            if (blocks->moveBlock != nil) {
                blocks->moveBlock(element->points[0]);
            }
            break;
        case kCGPathElementAddLineToPoint:
            if (blocks->lineBlock != nil) {
                blocks->lineBlock(element->points[0]);
            }
            break;
        case kCGPathElementAddQuadCurveToPoint:
            if (blocks->quadBlock) {
                blocks->quadBlock(element->points[0], element->points[1]);
            }
            break;
        case kCGPathElementAddCurveToPoint:
            if (blocks->cubicBlock) {
                blocks->cubicBlock(element->points[0], element->points[1], element->points[2]);
            }
            break;
        case kCGPathElementCloseSubpath:
            if (blocks->closeBlock) {
                blocks->closeBlock();
            }
            break;
    }
}

@implementation UIBezierPath (Rob_forEach)

- (void)Rob_forEachMove:(Rob_UIBezierPath_moveBlock)moveBlock line:(Rob_UIBezierPath_lineBlock)lineBlock quad:(Rob_UIBezierPath_quadBlock)quadBlock cubic:(Rob_UIBezierPath_cubicBlock)cubicBlock close:(Rob_UIBezierPath_closeBlock)closeBlock {
    struct ForEachBlocks blocks = {
        .moveBlock = moveBlock,
        .lineBlock = lineBlock,
        .quadBlock = quadBlock,
        .cubicBlock = cubicBlock,
        .closeBlock = closeBlock
    };
    CGPathApply(self.CGPath, &blocks, applyBlockToPathElement);
}

@end
