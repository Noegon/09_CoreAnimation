//
//  NGNOrbitsViewController.m
//  CoreAnimations
//
//  Created by Alexey Stafeyev on 19.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNOrbitsViewController.h"
#import "NGNOrbitView.h"

@interface NGNOrbitsViewController ()

@property (strong, nonatomic) IBOutlet NGNOrbitView *firstOrbitView;
@property (strong, nonatomic) IBOutlet NGNOrbitView *secondOrbitView;
@property (strong, nonatomic) IBOutlet NGNOrbitView *thirdOrbitView;

@end

@implementation NGNOrbitsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.secondOrbitView.mainOrbitLayer.transform = CATransform3DMakeScale(0.75, 0.75, 1);
    
    self.thirdOrbitView.mainOrbitLayer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
    
    self.secondOrbitView.mainOrbitLayer.borderColor = [UIColor blueColor].CGColor;
    self.secondOrbitView.mainPlanetLayer.backgroundColor = [UIColor blueColor].CGColor;

    self.thirdOrbitView.mainOrbitLayer.borderColor = [UIColor purpleColor].CGColor;
    self.thirdOrbitView.mainPlanetLayer.backgroundColor = [UIColor purpleColor].CGColor;
    
    
    [self.firstOrbitView.mainPlanetLayer addSublayer:self.secondOrbitView.underlyingLayer];
    [self.secondOrbitView.mainPlanetLayer addSublayer:self.thirdOrbitView.underlyingLayer];
    
    [self runSpinAnimationOnLayer:self.firstOrbitView.underlyingLayer
                         duration:1
                        rotations:0.1
                           repeat:1];
    
    [self runSpinAnimationOnLayer:self.secondOrbitView.underlyingLayer
                         duration:1
                        rotations:0.2
                           repeat:1];
    
    [self runSpinAnimationOnLayer:self.thirdOrbitView.underlyingLayer
                         duration:1
                        rotations:0.4
                           repeat:1];
    
}

- (void)runSpinAnimationOnLayer:(CALayer *)layer duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat ? HUGE_VALF : 0;
    
    [layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
