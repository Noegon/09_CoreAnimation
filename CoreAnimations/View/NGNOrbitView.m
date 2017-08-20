//
//  NGNOrbitView.m
//  CoreAnimations
//
//  Created by Alexey Stafeyev on 19.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNOrbitView.h"

@interface NGNOrbitView ()

@property (strong, nonatomic) IBOutlet UIView *entireView;
@property (strong, nonatomic) IBOutlet UIView *orbitSubview;
@property (strong, nonatomic) IBOutlet UIView *planetSubview;

@end

@implementation NGNOrbitView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self orbitViewInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self orbitViewInit];
    }
    return self;
}

- (void)orbitViewInit {
    [[NSBundle mainBundle] loadNibNamed:@"NGNOrbitView" owner:self options:nil];
    [self addSubview:self.entireView];
    self.entireView.frame = self.bounds;
    
    self.entireView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    self.backgroundColor = [UIColor clearColor];
    
    self.underlyingLayer = self.entireView.layer;
    self.mainOrbitLayer = self.orbitSubview.layer;
    self.mainPlanetLayer = self.planetSubview.layer;
    
    self.underlyingLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    self.mainOrbitLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.mainOrbitLayer.borderWidth = 3;
    self.mainOrbitLayer.borderColor = [UIColor redColor].CGColor;
    self.mainOrbitLayer.cornerRadius = CGRectGetWidth(self.orbitSubview.bounds) / 2;
    
    self.mainPlanetLayer.cornerRadius = CGRectGetWidth(self.planetSubview.bounds) / 2;
    self.mainPlanetLayer.backgroundColor = [UIColor redColor].CGColor;
}

@end
