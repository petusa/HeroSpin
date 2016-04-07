//
//  ContentService.h
//  HeroSpin
//
//  Created by Peter Nagy on 06/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

@class Hero;
@class Movie;
@class MovieDetail;

typedef void(^FetchMoviesReceivedBlock)(NSArray *movies);
typedef void(^FetchMovieDetailReceivedBlock)(MovieDetail *movieDetail);
typedef void(^FetchMoviesErrorBlock)(NSString *message);

@protocol ContentService <NSObject>

- (NSArray*)fetchHeroes;

- (void)fetchMoviesFor:(Hero*)hero
             onSuccess:(FetchMoviesReceivedBlock)successBlock
               onError:(FetchMoviesErrorBlock)errorBlock;

- (void)fetchMovieDetailFor:(Movie*)movie
                  onSuccess:(FetchMoviesErrorBlock)successBlock
                    onError:(FetchMoviesErrorBlock)errorBlock;

@end