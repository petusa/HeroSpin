//
//  Hero.m
//  HeroSpin
//
//  Created by Peter Nagy on 07/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import "Hero.h"

@implementation Hero

//-------------------------------------------------------------------------------------------
#pragma mark - Class Methods
//-------------------------------------------------------------------------------------------

+ (Hero*) withName:(NSString*)name image:(NSString*)image
{
    return [[Hero alloc] initWithName:name image:image];
}

//-------------------------------------------------------------------------------------------
#pragma mark - Initialization & Destruction
//-------------------------------------------------------------------------------------------

- (id) initWithName:(NSString*)name image:(NSString*)image
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _image = [image copy];
    }
    return self;
}

@end
