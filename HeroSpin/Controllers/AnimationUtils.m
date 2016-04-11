//
//  AnimationUtils.m
//  HeroSpin
//
//  Created by Peter Nagy on 09/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import "AnimationUtils.h"

@implementation AnimationUtils

static NSMutableDictionary *ANIMATIONS;

+ (void)initialize
{
    [super initialize];
    ANIMATIONS = [[NSMutableDictionary alloc] init];
}

+ (void)changeLayerPositionWithAnimation:(CALayer*)layer verticalYDelta:(float)yDelta withCompletionBlock:(AnimationCompletedBLock)block
{
    // save the original value
    CGFloat originalY = layer.position.y;
    
    // change the model value
    layer.position = CGPointMake(layer.position.x, layer.position.y + yDelta);
    
    CABasicAnimation* translationAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"]; // transform.translation
    // translationAnimation.toValue = [NSNumber numberWithFloat:yDelta];
    translationAnimation.fromValue = @(originalY);
    translationAnimation.duration = 0.5;
    translationAnimation.cumulative = NO;
    translationAnimation.repeatCount = 1.0;
    translationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    translationAnimation.removedOnCompletion = YES;
    translationAnimation.fillMode = kCAFillModeForwards;
    
    // add animation with completion block or without
    if (block) {
        [CATransaction begin]; {
            [CATransaction setCompletionBlock:block];
            [layer addAnimation:translationAnimation forKey:@"p"];
        } [CATransaction commit];
    } else {
        [layer addAnimation:translationAnimation forKey:@"p"];
    }
}

+ (void)addPulseAnimation:(CALayer*)layer withId:(NSString*)animationId
{
    // clear animations
    [layer removeAllAnimations];
    
    // add animations
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.duration = .5;
    pulseAnimation.toValue = [NSNumber numberWithFloat:1.1];
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount = MAXFLOAT;
    [layer addAnimation:pulseAnimation forKey:@"a"];
    [ANIMATIONS setValue:layer forKey:animationId];
}

+ (void)addRadarSignalAnimation:(UIView*)uiView withId:(NSString*)animationId
{
    // create radar frame
    UIView *radarFrame = [uiView viewWithTag:1];
    if (!radarFrame) {
        radarFrame = [[UIView alloc] initWithFrame:uiView.bounds];
        radarFrame.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
        radarFrame.userInteractionEnabled = NO;
        radarFrame.layer.cornerRadius = 64;
        radarFrame.tag = 1;
        [uiView addSubview:radarFrame];
        [uiView sendSubviewToBack:radarFrame];
    }
    // clear animations
    [radarFrame.layer removeAllAnimations];
    
    // add animations
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.toValue = @0;
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.toValue = @2;
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[fade,pulse];
    group.duration = 1;
    group.repeatCount = MAXFLOAT;
    [radarFrame.layer addAnimation:group forKey:@"g"];
    [ANIMATIONS setObject:radarFrame.layer forKey:animationId];
}

+(void)start:(NSString*)_animationId
{
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        CALayer *layer = (CALayer*)[ANIMATIONS objectForKey:_animationId];
        layer.timeOffset = 0;
        layer.beginTime = 0.0;
        layer.speed = 1.0;
    });
}

+(void)reset:(NSString*)_animationId
{
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        CALayer *layer = (CALayer*)[ANIMATIONS objectForKey:_animationId];
        layer.speed = 0.0;
        layer.timeOffset = 0;
        layer.beginTime = 0.0;
    });
}

+(void)pause:(NSString*)_animationId
{
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        CALayer *layer = (CALayer*)[ANIMATIONS objectForKey:_animationId];
        CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
        layer.speed = 0.0;
        layer.timeOffset = pausedTime;
    });
}

+(void)resume:(NSString*)_animationId
{
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        CALayer *layer = (CALayer*)[ANIMATIONS objectForKey:_animationId];
        CFTimeInterval pausedTime = [layer timeOffset];
        layer.speed = 1.0;
        layer.timeOffset = 0.0;
        layer.beginTime = 0.0;
        CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        layer.beginTime = timeSincePause;
    });
}

@end
