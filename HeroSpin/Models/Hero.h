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
@property (nonatomic, strong, readonly) NSString *imagePath;
@property (nonatomic, strong, readonly) NSString *creator;
@property (nonatomic, strong, readonly) NSString *type;

+ (id) withName:(NSString*)name imagePath:(NSString*)path creator:(NSString*)creator type:(NSString*)type;

- (id) initWithName:(NSString*)name imagePath:(NSString*)path creator:(NSString*)creator type:(NSString*)type;

- (NSString*)description;

@end
