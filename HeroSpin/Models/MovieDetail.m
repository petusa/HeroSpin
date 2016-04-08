//
//  MovieDetail.m
//  HeroSpin
//
//  Created by Peter Nagy on 07/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import "MovieDetail.h"

@implementation MovieDetail

//-------------------------------------------------------------------------------------------
#pragma mark - Class Methods
//-------------------------------------------------------------------------------------------

+ (MovieDetail*) movieDetailWithData:(NSDictionary*) data
{
    return [[MovieDetail alloc] initWithData:data];
}

//-------------------------------------------------------------------------------------------
#pragma mark - Initialization & Destruction
//-------------------------------------------------------------------------------------------

- (id) initWithData:(NSDictionary*) data
{
    self = [super initWithData:data];
    if (self) {
        _Rated = [data objectForKey:@"Rated"];
        _Released = [data objectForKey:@"Released"];
        _Runtime = [data objectForKey:@"Runtime"];
        _Genre = [data objectForKey:@"Genre"];
        _Director = [data objectForKey:@"Director"];
        _Writer = [data objectForKey:@"Writer"];
        _Actors = [data objectForKey:@"Actors"];
        _Plot = [data objectForKey:@"Plot"];
        _Language = [data objectForKey:@"Language"];
        _Country = [data objectForKey:@"Country"];
        _Awards = [data objectForKey:@"Awards"];
        _Metascore = [data objectForKey:@"Metascore"];
        _imdbRating = [data objectForKey:@"imdbRating"];
        _imdbVotes = [data objectForKey:@"imdbVotes"];
    }
    return self;
}

- (NSString*) description
{
    return [[super description] stringByAppendingString:[NSString stringWithFormat:@"\n\tPlot: %@", _Plot ]];
}

@end
