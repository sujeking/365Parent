//
//  GPRoundView.m
//  RoundRound
//
//  Created by crazypoo on 14/7/28.
//  Copyright (c) 2014年 crazypoo. All rights reserved.
//

#import "GPRoundView.h"
#import <QuartzCore/QuartzCore.h>

@implementation GPRoundView

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setColor];
        self.layer.mask = [self drawRound];
    }
    return self;
}

-(void)setColor
{
    CAGradientLayer *gradientLayer = (id)[self layer];
    
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(1.0, 0.0);
    
    NSMutableArray *colors = [NSMutableArray array];
    for (NSInteger hue = 0; hue <= 100; hue += 10) {
        //<=100黄绿,<=300蓝绿淡黄
        [colors addObject:(id)[UIColor colorWithHue:1.0*hue/360.0 saturation:1.0 brightness:1.0 alpha:1.0].CGColor];
    }
    [gradientLayer setColors:[NSArray arrayWithArray:colors]];
}

-(CAShapeLayer *)drawRound
{
    CGPoint circleCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat circleRadius = self.bounds.size.width/2.0 - 40;
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:circleCenter
                                                              radius:circleRadius
                                                          startAngle:M_PI
                                                            endAngle:-M_PI
                                                           clockwise:NO];

    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.path = circlePath.CGPath;
    circleLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    circleLayer.fillColor = [[UIColor clearColor] CGColor];
    circleLayer.lineWidth = 2;
    circleLayer.strokeStart = 0;
    circleLayer.strokeEnd = 1.0;
    
    return circleLayer;
}

-(void)starRun
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    animation.fromValue = [NSNumber numberWithDouble:0];
    animation.toValue = [NSNumber numberWithDouble:M_PI*2];
    [self.layer addAnimation:animation forKey:@"transform"];
}

-(void)stopRun
{
    self.alpha =0;
    [self.layer removeAllAnimations];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
