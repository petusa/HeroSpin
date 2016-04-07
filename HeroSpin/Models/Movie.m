//
//  Movie.m
//  HeroSpin
//
//  Created by Peter Nagy on 07/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import "Movie.h"

@implementation Movie

//-------------------------------------------------------------------------------------------
#pragma mark - Class Methods
//-------------------------------------------------------------------------------------------

+ (Movie*) movieWithData:(NSDictionary*) data {
    return [[Movie alloc] initWithData:data];
}

+ (MovieType) movieTypeFrom:(NSString*) name {
    NSDictionary *moviesTypeDict = @{
                                     @"movie": @(movie),
                                     @"series": @(series),
                                     @"episode": @(episode)
                                     };
    return (MovieType)[[moviesTypeDict objectForKey:name] intValue];
}

+ (NSString*) movieTypeNameFrom:(MovieType) type {
    NSDictionary *moviesTypeNameDict = @{
                                         @(movie): @"movie",
                                         @(series): @"series",
                                         @(episode): @"episode"
                                         };
    return (NSString*)[moviesTypeNameDict objectForKey:[NSNumber numberWithInt:type]];
}

//-------------------------------------------------------------------------------------------
#pragma mark - Initialization & Destruction
//-------------------------------------------------------------------------------------------

- (id) initWithData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        _Title = [data objectForKey:@"Title"];
        _Year = [[data objectForKey:@"Year"] intValue];
        _imdbID = [data objectForKey:@"imdbID"];
        _Type = [Movie movieTypeFrom:[data objectForKey:@"Type"]];
        _Poster = [NSURL URLWithString:[data objectForKey:@"Poster"]];
    }
    return self;
}

@end