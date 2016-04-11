//
//  AnimationUtils.h
//  HeroSpin
//
//  Created by Peter Nagy on 09/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^AnimationCompletedBLock)();

@interface AnimationUtils : NSObject

+ (void)changeLayerPositionWithAnimation:(CALayer*)layer verticalYDelta:(float)yDelta withCompletionBlock:(AnimationCompletedBLock)block;

+ (void)addPulseAnimation:(CALayer*)layer withId:(NSString*)animationId;

+ (void)addRadarSignalAnimation:(UIView*)uiView withId:(NSString*)animationId;

+ (void)start:(NSString*)animationId;

+ (void)reset:(NSString*)animationId;

+ (void)pause:(NSString*)animationId;

+ (void)resume:(NSString*)animationId;

@end
