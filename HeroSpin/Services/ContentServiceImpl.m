//
//  ContentServiceImpl.m
//  HeroSpin
//
//  Created by Peter Nagy on 06/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import "ContentServiceImpl.h"
#import <UIKit/UIKit.h>
#import "Hero.h"
#import "Movie.h"
#import "MovieDetail.h"
#import "NSURL+QueryDictionary.h"

@interface ContentServiceImpl ()

@end

@implementation ContentServiceImpl

NSString *const CHARACTERS_PREFIX = @"characters_";

// TODO make it more robust, add error handling, implement UTs
- (NSArray *)fetchHeroes
{
    NSMutableArray *heroes = [[NSMutableArray alloc] init];
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *imagesPath = [resourcePath stringByAppendingPathComponent:@"Images"];
    NSError *error;
    NSArray *directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:imagesPath error:&error];
    for (int i=0; i<[directoryContents count]; i++) {
        NSString *folderName = [directoryContents objectAtIndex:i];
        if ([folderName hasPrefix:CHARACTERS_PREFIX]) {
            NSArray *parts = [folderName componentsSeparatedByString:@"_"];
            if ([parts count] > 2) {
                NSString* heroCreator = [parts objectAtIndex:1];
                NSString* heroType = [folderName substringFromIndex:([CHARACTERS_PREFIX length] + [heroCreator length] + 1)];
                NSString* heroImagesPath = [imagesPath stringByAppendingPathComponent:folderName];
                NSArray * heroImages = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:heroImagesPath error:&error];
                for (int h=0; h < [heroImages count]; h++) {
                    NSString* fileName = [heroImages objectAtIndex:h];
                    if ([fileName hasSuffix:@".jpg"] || [fileName hasSuffix:@".png"]) {
                        Hero *hero = [Hero withName:[fileName substringToIndex:[fileName length]-4] // from file name
                                          imagePath:[heroImagesPath stringByAppendingPathComponent:fileName]
                                            creator:heroCreator
                                               type:heroType];
                        [heroes addObject:hero];
                    }
                }
            }
        }
    }
    return heroes;
}

- (void)fetchMoviesFor:(Hero*)hero
             onSuccess:(FetchMoviesReceivedBlock)successBlock
               onError:(FetchMoviesErrorBlock)errorBlock
{
    if (hero) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
            NSLog(@"query: %@", [self queryURLForMovies:hero.name]);
            NSString* errorMessage = nil;
            NSDictionary* jsonData = [self sendRequest:[self queryURLForMovies:hero.name] error:&errorMessage];
            if (errorMessage && errorBlock) {
                dispatch_async(dispatch_get_main_queue(), ^ {
                    errorBlock(errorMessage.length == 0 ? @"Unexpected error." : errorMessage);
                });
            } else if (successBlock) {
                NSArray *moviesData = [jsonData objectForKey:@"Search"];
                NSMutableArray *movies = [[NSMutableArray alloc] initWithCapacity:[moviesData count]];
                for (int m=0; m<[moviesData count]; m++) {
                    Movie *movie = [Movie movieWithData:moviesData[m]];
                    [movies addObject:movie];
                }
                dispatch_async(dispatch_get_main_queue(), ^ {
                    successBlock(movies);
                });
            }
        });
    }
}

- (void)fetchMovieDetailFor:(Movie*)movie
                  onSuccess:(FetchMovieDetailReceivedBlock)successBlock
                    onError:(FetchMoviesErrorBlock)errorBlock
{
    if (movie) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
            NSLog(@"query: %@", [self queryURLForMovies:movie.imdbID]);
            NSString* errorMessage = nil;
            NSDictionary* jsonData = [self sendRequest:[self queryURLForMovieDetail:movie.imdbID] error:&errorMessage];
            if (errorMessage && errorBlock) {
                dispatch_async(dispatch_get_main_queue(), ^ {
                    errorBlock(errorMessage.length == 0 ? @"Unexpected error." : errorMessage);
                });
            } else if (successBlock) {
                NSDictionary *movieDetailData = jsonData;
                MovieDetail *movieDetail = [MovieDetail movieDetailWithData:movieDetailData];
                dispatch_async(dispatch_get_main_queue(), ^ {
                    successBlock(movieDetail);
                });
            }
        });
    }
}

//-------------------------------------------------------------------------------------------
#pragma mark - Private Methods
//-------------------------------------------------------------------------------------------

- (NSDictionary*)sendRequest:(NSURL*)url error:(NSString**)errorMessage
{
    // handling all possible error here, communication, parsing, error in result
    NSDictionary *jsonData = nil;
    NSError *error = nil;
    NSData* responseData = [NSData dataWithContentsOfURL:url options:kNilOptions error:&error];
    if (error != nil) {
        [error.userInfo setValue:@"Communication error" forKey:NSLocalizedDescriptionKey];
    } else {
        jsonData = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        if (error != nil) {
            [error.userInfo setValue:@"Error while parsing JSON response" forKey:NSLocalizedDescriptionKey];
        } else {
            if (! [jsonData objectForKey:@"Response"] || ! [[jsonData objectForKey:@"Response"] isEqualToString:@"True"]) {
                error = [[NSError alloc] initWithDomain:@"Response error" code:9999 userInfo: @{ (NSLocalizedDescriptionKey) : @"Error indication in response data"}];
            }
        }
    }
    *errorMessage = (error) ? [[error.userInfo objectForKey:NSLocalizedDescriptionKey] copy] : nil;
    return jsonData;
}

- (NSURL*)queryURLForMovies:(NSString*)searchString
{
    NSURL* url = [self.serviceUrl uq_URLByAppendingQueryDictionary:@{
                                                                     (@"s"): searchString,
                                                                     (@"r"): @"json"
                                                                    }];
    return url;
}

- (NSURL*)queryURLForMovieDetail:(NSString*)moviId
{
    NSURL* url = [self.serviceUrl uq_URLByAppendingQueryDictionary:@{
                                                                     (@"i"): moviId,
                                                                     (@"r"): @"json"
                                                                     }];
    return url;
}

@end
