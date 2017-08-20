//
//  NGNRunningLineViewController.m
//  CoreAnimations
//
//  Created by Alexey Stafeyev on 19.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNRunningLineViewController.h"

@interface NGNRunningLineViewController ()

@property (strong, nonatomic) IBOutlet UILabel *runningLineLabel;

@end

@implementation NGNRunningLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.fromValue = @(0.0 - self.runningLineLabel.bounds.size.width / 2);
    animation.toValue = @(self.view.bounds.size.width + self.runningLineLabel.bounds.size.width / 2);
    animation.duration = 5;
    animation.repeatCount = HUGE_VALF;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.runningLineLabel.layer addAnimation:animation forKey:@"basic"];
}

@end
