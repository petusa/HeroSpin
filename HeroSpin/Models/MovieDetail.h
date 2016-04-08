//
//  MovieDetail.h
//  HeroSpin
//
//  Created by Peter Nagy on 07/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import "Movie.h"

@interface MovieDetail : Movie

//@property (nonatomic, strong, readonly) NSString *Title;
//@property (nonatomic, readonly) int Year;
//@property (nonatomic, strong, readonly) NSString *imdbID;
//@property (nonatomic, readonly) MovieType Type;
//@property (nonatomic, strong, readonly) NSURL *Poster;
@property (nonatomic, strong, readonly) NSString *Rated;
@property (nonatomic, strong, readonly) NSString *Released;
@property (nonatomic, strong, readonly) NSString *Runtime;
@property (nonatomic, strong, readonly) NSString *Genre;
@property (nonatomic, strong, readonly) NSString *Director;
@property (nonatomic, strong, readonly) NSString *Writer;
@property (nonatomic, strong, readonly) NSString *Actors;
@property (nonatomic, strong, readonly) NSString *Plot;
@property (nonatomic, strong, readonly) NSString *Language;
@property (nonatomic, strong, readonly) NSString *Country;
@property (nonatomic, strong, readonly) NSString *Awards;
@property (nonatomic, strong, readonly) NSString *Metascore;
@property (nonatomic, strong, readonly) NSString *imdbRating;
@property (nonatomic, strong, readonly) NSString *imdbVotes;

+ (MovieDetail*) movieDetailWithData:(NSDictionary*) data;

- (id) initWithData:(NSDictionary*) data;

- (NSString*) description;

@end
