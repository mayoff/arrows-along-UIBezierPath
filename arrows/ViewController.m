//
//  ViewController.m
//  arrows
//
//  Created by Rob Mayoff on 9/30/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import "ViewController.h"
#import "UIBezierPath+Rob_figureEight.h"
#import "UIBezierPath+Rob_dash.h"
#import "UIBezierPath+Rob_arrowized.h"

@interface ViewController ()

@end

@implementation ViewController {
    CAShapeLayer *shapeLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initShapeLayer];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self layoutShapeLayer];
    [self setShapeLayerPath];
}

- (void)initShapeLayer {
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.lineWidth = 1.5;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.fillColor = nil;
    [self.view.layer addSublayer:shapeLayer];
}

- (void)layoutShapeLayer {
    shapeLayer.frame = self.view.bounds;
}

- (void)setShapeLayerPath {
    UIBezierPath *path = [UIBezierPath Rob_figureEightInRect:CGRectInset(self.view.bounds, 40, 40)];
    path = [path Rob_dashedPathWithPattern:@[ @30 ] phase:15];
    path = [path Rob_arrowizedPathWithHeadLength:8 headAngleRadians:M_PI / 12];
    shapeLayer.path = path.CGPath;
}

@end
