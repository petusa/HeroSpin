//
//  AppModel.m
//  HeroSpin
//
//  Created by Peter Nagy on 09/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import "AppModel.h"
#import "Hero.h"

@implementation AppModel
@synthesize PickedMoviesHistory = _PickedMoviesHistory;

- (id)init
{
    self = [super init];
    if (self) {
        _PickedMoviesHistory = [[NSMutableArray alloc] init];
    }
    return self;
}


// to make sure that the very first hero among the heroes does not count as a concrete hero
- (void)setSelectedHero:(Hero*)hero {
    if ([hero.name isEqualToString:RANDOM_HERO_NAME]) {
        _SelectedHero = nil;
    } else {
        _SelectedHero = hero;
    }
}

@end
