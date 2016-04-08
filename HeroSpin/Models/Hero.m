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

+ (Hero*) withName:(NSString*)name imagePath:(NSString*)path creator:(NSString*)creator type:(NSString*)type
{
    return [[Hero alloc] initWithName:name imagePath:path creator:creator type:type];
}

//-------------------------------------------------------------------------------------------
#pragma mark - Initialization & Destruction
//-------------------------------------------------------------------------------------------

- (id) initWithName:(NSString*)name imagePath:(NSString*)path creator:(NSString*)creator type:(NSString*)type
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _imagePath = [path copy];
        _creator = [creator copy];
        _type = [type copy];
    }
    return self;
}

- (NSString*) description
{
    return [NSString stringWithFormat:@"Hero: name=%@, image path=%@, type=%@", _name, _imagePath, _type];
}

@end
