//
//  ViewController.m
//  arrows
//
//  Created by Rob Mayoff on 9/30/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import "ViewController.h"
#import "ArrowView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet ArrowView *arrowView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateArrowView];
}

- (IBAction)updateArrowView {
    self.arrowView.interval = self.slider.value;
}

@end
