//
//  AnimationUtils.h
//  HeroSpin
//
//  Created by Peter Nagy on 09/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AnimationUtils : NSObject

+ (void)changeLayerPositionWithAnimation:(CALayer*)layer verticalYDelta:(float)yDelta;

@end
