//
//  Hero.h
//  HeroSpin
//
//  Created by Peter Nagy on 07/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hero : NSObject

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *image;

+ (id) withName:(NSString*)name image:(NSString*)image;

- (id) initWithName:(NSString*)name image:(NSString*)image;

@end
