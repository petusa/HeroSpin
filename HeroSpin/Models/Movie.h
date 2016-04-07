//
//  Movie.h
//  HeroSpin
//
//  Created by Peter Nagy on 07/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    movie,
    series,
    episode
} MovieType;

@interface Movie : NSObject

@property (nonatomic, strong, readonly) NSString *Title;
@property (nonatomic, readonly) int Year;
@property (nonatomic, strong, readonly) NSString *imdbID;
@property (nonatomic, readonly) MovieType Type;
@property (nonatomic, strong, readonly) NSURL *Poster;

+ (Movie*) movieWithData:(NSDictionary*) data;
+ (MovieType) movieTypeFrom:(NSString*) name;
+ (NSString*) movieTypeNameFrom:(MovieType) type;

- (id) initWithData:(NSDictionary*) data;

@end
