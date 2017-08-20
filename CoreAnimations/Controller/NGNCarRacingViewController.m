//
//  NGNCarRacingViewController.m
//  CoreAnimations
//
//  Created by Alexey Stafeyev on 19.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNCarRacingViewController.h"

@interface NGNCarRacingViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *carImageView;

@end

@implementation NGNCarRacingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    CGPoint startPoint = CGPointMake(CGRectGetWidth(self.view.bounds) - 80, 0);
    
    UIBezierPath *trackPath = [UIBezierPath bezierPath];
    [trackPath moveToPoint:startPoint];
    [trackPath addLineToPoint:CGPointMake(CGRectGetWidth(self.view.bounds) - 50,
                                           CGRectGetHeight(self.view.bounds) / 2)];
    
    [trackPath addCurveToPoint:CGPointMake(CGRectGetWidth(self.view.bounds) - 150,
                                           CGRectGetHeight(self.view.bounds) - 100)
                 controlPoint1:CGPointMake(CGRectGetWidth(self.view.bounds) - 50,
                                           CGRectGetHeight(self.view.bounds) - 150)
                 controlPoint2:CGPointMake(CGRectGetWidth(self.view.bounds) - 50,
                                           CGRectGetHeight(self.view.bounds) - 200)];
    
    [trackPath addQuadCurveToPoint:CGPointMake(50, 350)
                      controlPoint:CGPointMake(150, CGRectGetHeight(self.view.bounds))];
    
    [trackPath addCurveToPoint:CGPointMake(100, 0)
                 controlPoint1:CGPointMake(0, 50)
                 controlPoint2:CGPointMake(100, 450)];
    
    [trackPath addQuadCurveToPoint:startPoint
                      controlPoint:CGPointMake(CGRectGetWidth(self.view.bounds) / 2, -200)];

#warning not very beautiful descision: maybe I could do it in single layer?
    CAShapeLayer *line = [CAShapeLayer layer];
    line.lineWidth = 3.0;
    line.path = trackPath.CGPath;
    line.bounds = self.view.bounds;
    line.position = self.view.center;
    line.fillColor = [UIColor clearColor].CGColor;
    line.strokeColor = [UIColor whiteColor].CGColor;
    line.lineJoin = kCALineJoinRound;
    line.lineDashPattern = @[@10, @5];
    
    CAShapeLayer *road = [[CAShapeLayer alloc] initWithLayer:line];
    road.lineWidth = 20.0;
    road.path = trackPath.CGPath;
    line.bounds = self.view.bounds;
    line.position = self.view.center;
    road.fillColor = [UIColor clearColor].CGColor;
    road.strokeColor = [UIColor blackColor].CGColor;
    road.lineDashPattern = nil;
    
    [road addSublayer:line];
    [self.view.layer addSublayer:road];
    
    CALayer *car = [CALayer layer];
    car.bounds = CGRectMake(startPoint.x, startPoint.y, 83, 37);
    car.position = CGPointMake(CGRectGetMidX(car.bounds), CGRectGetMidY(car.bounds));
    car.contents = (id)([UIImage imageNamed:@"blue-top-car.png"].CGImage);
    [self.view.layer addSublayer:car];
    
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = trackPath.CGPath;
    moveAnim.removedOnCompletion = NO;
    moveAnim.duration = 10.0;
    moveAnim.rotationMode = @"auto";
    moveAnim.repeatCount = HUGE_VALF;
    [car addAnimation:moveAnim forKey:@"position"];
}

@end
