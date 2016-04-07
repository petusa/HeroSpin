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

@interface ContentServiceImpl ()

@end

@implementation ContentServiceImpl

NSString *const CHRACTERS_PREFIX = @"characters_";

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
        if ([folderName hasPrefix:CHRACTERS_PREFIX]) {
            NSArray *parts = [folderName componentsSeparatedByString:@"_"];
            if ([parts count] > 2) {
                NSString* heroCreator = [parts objectAtIndex:1];
                NSString* heroType = [folderName substringFromIndex:([CHRACTERS_PREFIX length] + [heroCreator length] + 1)];
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
               onError:(FetchMoviesErrorBlock)errorBlock {}

- (void)fetchMovieDetailFor:(Movie*)movie
                  onSuccess:(FetchMoviesErrorBlock)successBlock
                    onError:(FetchMoviesErrorBlock)errorBlock {}

@end
