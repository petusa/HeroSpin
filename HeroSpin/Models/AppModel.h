//
//  AppModel.h
//  HeroSpin
//
//  Created by Peter Nagy on 09/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Hero;
@class Movie;
@class MovieDetail;

@interface AppModel : NSObject
@property (nonatomic, strong) Hero *SelectedHero;
@property (nonatomic, strong) Movie *SelectedMovie;
@property (nonatomic, strong) MovieDetail *SelectedMovieDetail;
@property (nonatomic, strong) NSMutableArray *PickedMoviesHistory;
@end
