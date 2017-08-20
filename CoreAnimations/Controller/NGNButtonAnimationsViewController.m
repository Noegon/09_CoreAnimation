//
//  NGNButtonAnimationsViewController.m
//  CoreAnimations
//
//  Created by Alexey Stafeyev on 19.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNButtonAnimationsViewController.h"

@interface NGNButtonAnimationsViewController () <CAAnimationDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *carToDeleteImage;
@property (strong, nonatomic) IBOutlet UIImageView *trashCartImage;

- (IBAction)scaleButtonTapped:(UIButton *)sender;


@end

@implementation NGNButtonAnimationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapOnCarGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteCar)];
    [self.carToDeleteImage addGestureRecognizer:tapOnCarGesture];
}

- (IBAction)scaleButtonTapped:(UIButton *)sender {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.duration = 0.125;
    anim.repeatCount = 1;
    anim.autoreverses = YES;
    anim.removedOnCompletion = YES;
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)];
    [sender.layer addAnimation:anim forKey:nil];
}

- (IBAction)deleteCar {
    NSLog(@"%@", @"car was deleted");
    
    //doing car smaller
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    scaleAnim.removedOnCompletion = YES;
    
    //doing car transparent
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    
    //moving car on bezier path
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    CGPoint centralPoint = CGPointMake(self.trashCartImage.center.x, self.carToDeleteImage.center.x);
    [movePath moveToPoint:self.carToDeleteImage.center];
    [movePath addQuadCurveToPoint:self.trashCartImage.center
                     controlPoint:centralPoint];
    
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = YES;
    
    //adding all animations into group
//    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
//    animGroup.animations = [NSArray arrayWithObjects:moveAnim, scaleAnim, opacityAnim, nil];
//    animGroup.duration = 0.5;
//    [self.carToDeleteImage.layer addAnimation:animGroup forKey:nil];
    
    [CATransaction begin]; {
        [CATransaction setCompletionBlock:^{
            [self.carToDeleteImage removeFromSuperview];
        }];
        [self.carToDeleteImage.layer addAnimation:scaleAnim forKey:@"transform"];
        [self.carToDeleteImage.layer addAnimation:opacityAnim forKey:@"alpha"];
        [self.carToDeleteImage.layer addAnimation:moveAnim forKey:@"position"];
    } [CATransaction commit];
    
}

@end
