//
//  AnimationUtils.m
//  HeroSpin
//
//  Created by Peter Nagy on 09/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import "AnimationUtils.h"

@implementation AnimationUtils

+ (void)changeLayerPositionWithAnimation:(CALayer*)layer verticalYDelta:(float)yDelta
{
    // Save the original value
    CGFloat originalY = layer.position.y;
    
    // Change the model value
    layer.position = CGPointMake(layer.position.x, layer.position.y + yDelta);
    
    CABasicAnimation* translationAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"]; // transform.translation
    // translationAnimation.toValue = [NSNumber numberWithFloat:yDelta];
    translationAnimation.fromValue = @(originalY);
    translationAnimation.duration = 1;
    translationAnimation.cumulative = NO;
    translationAnimation.repeatCount = 1.0;
    translationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    translationAnimation.removedOnCompletion = YES;
    translationAnimation.fillMode = kCAFillModeForwards;
    [layer addAnimation:translationAnimation forKey:@"p"];
}

@end
