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

    self.secondOrbitView.underlyingLayer.transform = CATransform3DMakeScale(.75, .75, 1);
//    self.secondOrbitView.backgroundColor = [UIColor cyanColor];
//    self.secondOrbitView.underlyingLayer.backgroundColor = [UIColor greenColor].CGColor;
    
    self.thirdOrbitView.underlyingLayer.transform = CATransform3DMakeScale(.5, .5, 1);
//    self.thirdOrbitView.underlyingLayer.backgroundColor = [UIColor greenColor].CGColor;
//    self.thirdOrbitView.backgroundColor = [UIColor cyanColor];
    
#warning how to calculate anchor point after scaling? Behavior of orbit layer after scaling is strange
    self.secondOrbitView.underlyingLayer.anchorPoint = CGPointMake(0.69, 0.69);
    self.secondOrbitView.mainOrbitLayer.borderColor = [UIColor blueColor].CGColor;
    self.secondOrbitView.mainPlanetLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    self.thirdOrbitView.underlyingLayer.anchorPoint = CGPointMake(1.1, 1.1);
    self.thirdOrbitView.mainOrbitLayer.borderColor = [UIColor purpleColor].CGColor;
    self.thirdOrbitView.mainPlanetLayer.backgroundColor = [UIColor purpleColor].CGColor;
    
    [self.firstOrbitView.mainPlanetLayer addSublayer:self.secondOrbitView.underlyingLayer];
    [self.secondOrbitView.mainPlanetLayer addSublayer:self.thirdOrbitView.underlyingLayer];
    
    [self runSpinAnimationOnLayer:self.firstOrbitView.underlyingLayer
                         duration:1
                        rotations:0.5
                           repeat:1];
    
    [self runSpinAnimationOnLayer:self.secondOrbitView.mainOrbitLayer
                         duration:1
                        rotations:0.5
                           repeat:1];
    
    [self runSpinAnimationOnLayer:self.thirdOrbitView.mainOrbitLayer
                         duration:1
                        rotations:0.5
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
