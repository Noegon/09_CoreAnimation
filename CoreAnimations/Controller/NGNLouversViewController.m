//
//  NGNLouversViewController.m
//  CoreAnimations
//
//  Created by Alexey Stafeyev on 19.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNLouversViewController.h"

@interface NGNLouversViewController ()

@property (strong, nonatomic) NSMutableArray<CALayer *> *image1Layers;
@property (strong, nonatomic) NSMutableArray<CALayer *> *image2Layers;
@property (strong, nonatomic) IBOutlet UIButton *changeImageButton;

- (IBAction)changeImageButtonTapped:(UIButton *)sender;

@end

@implementation NGNLouversViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.image1Layers = [[NSMutableArray alloc] init];
    self.image2Layers = [[NSMutableArray alloc] init];
    
    self.changeImageButton.layer.zPosition = 1000;
    
    CGFloat layerHeight = CGRectGetHeight(self.view.bounds) / 20;
    
    for (int i = 0; i < 20; i++) {
        CALayer *layer1 = [self createSubLayerWithImageName:@"cosmic_wallpaper"
                                              sublayerIndex:i sublayerHeight:layerHeight];
        layer1.zPosition = 1;
        CALayer *layer2 = [self createSubLayerWithImageName:@"aqua_wallpaper"
                                              sublayerIndex:i sublayerHeight:layerHeight];
        layer2.zPosition = -1;
        
        [self.image1Layers addObject:layer1];
        [self.image2Layers addObject:layer2];
        
        [self.view.layer insertSublayer:layer1 below:self.changeImageButton.layer];
        [self.view.layer insertSublayer:layer2 below:layer1];
    }
}

- (void)addAnimationToLayer:(CALayer *)layer {
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
    rotation.keyPath = @"transform.rotation.x";
    rotation.values = @[@1, @0, @0];
    rotation.duration = 2.0;
    rotation.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
    
    CABasicAnimation *zPosition = [CABasicAnimation animation];
    zPosition.keyPath = @"zPosition";
    zPosition.fromValue = @1;
    zPosition.toValue = @(-1);
    zPosition.duration = 2.0;
    
    [CATransaction begin]; {
        [CATransaction setCompletionBlock:^{
            self.changeImageButton.userInteractionEnabled = YES;
        }];
        [layer addAnimation:zPosition forKey:@"zPosition"];
        [layer addAnimation:rotation forKey:@"rotation"];
    } [CATransaction commit];
}

- (CALayer *)createSubLayerWithImageName:(NSString *)imageName
                           sublayerIndex:(NSUInteger)idx
                          sublayerHeight:(CGFloat)height {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, idx * height, CGRectGetWidth(self.view.bounds), height);
    layer.contents = (__bridge id)[UIImage imageNamed:imageName].CGImage;
    layer.contentsRect = CGRectMake(0, idx * 0.05, 1, 0.05);
    layer.masksToBounds = YES;
    return layer;
}

- (IBAction)changeImageButtonTapped:(UIButton *)sender {
    self.changeImageButton.userInteractionEnabled = NO;
    NSArray *upperLayerArray = nil;
    NSArray *downLayerArray = nil;
    if (self.image1Layers.firstObject.zPosition > self.image2Layers.firstObject.zPosition) {
        upperLayerArray = self.image1Layers;
        downLayerArray = self.image2Layers;
    } else {
        upperLayerArray = self.image2Layers;
        downLayerArray = self.image1Layers;
    }
    for (CALayer *layer in upperLayerArray) {
        [self addAnimationToLayer:layer];
        layer.zPosition = -1;
    }
    for (CALayer *layer in downLayerArray) {
        layer.zPosition = 1;
    }
}

@end
