//
//  HeroSpinTests.m
//  HeroSpinTests
//
//  Created by Peter Nagy on 05/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Hero.h"
#import "Movie.h"
#import "MovieDetail.h"
#import "Typhoon.h"
#import "ContentService.h"
#import "AppAssembly.h"

@interface HeroSpinTests : XCTestCase

@end

@implementation HeroSpinTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testModels {
    // testing Hero creation
    Hero* Batman = [Hero withName:@"Batman" imagePath:@"batman.jpg" creator:@"Bob Kane, Bill Finger" type:@"Top heroes"];
    XCTAssert([Batman.name isEqualToString:@"Batman"], @"Could not create Hero instance with static class method.");
    
    // testing Movie class, with movie type converters
    Movie* BatmanReturnsMovie = [Movie movieWithData:@{ (@"Title"):@"Batman Returns", (@"Type"):@"movie" }];
    XCTAssert([BatmanReturnsMovie.Title isEqualToString:@"Batman Returns"], @"Could not create Movie instance with static class method.");
    XCTAssert(BatmanReturnsMovie.Type == movie, @"Type conversion string => movie type does not operate proeprly");
    XCTAssert([[Movie movieTypeNameFrom:movie] isEqualToString:@"movie"], @"Type conversion movie type => string does not operate proeprly");
   
    // tetsing MovieDetail child class instantiation
    MovieDetail* BatmanReturnsMovieWithDetail = [MovieDetail movieDetailWithData:@{ (@"Title"):@"Batman Returns", (@"Type"):@"movie", (@"Genre"):@"Action"}];
    XCTAssert([BatmanReturnsMovieWithDetail.Title isEqualToString:@"Batman Returns"], @"Could not create MovieDetail instance with static class method and calling super.");
    XCTAssert([BatmanReturnsMovieWithDetail.Genre isEqualToString:@"Action"], @"Could not create MovieDetail instance with static class method and calling super.");
}

- (void)testContentService {
    // create content service
    AppAssembly *assembly = [[AppAssembly new] activate];
    id<ContentService> contentService = [assembly contentService];
    XCTAssert(contentService);
    
    // obtain heroes
    NSArray *heroes = [contentService fetchHeroes];
    XCTAssert([heroes count] > 0, @"Could not obtain any heroes.");
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Expecting to get results from remote calls."];
    Hero *firstHero = heroes[0];
    [contentService fetchMoviesFor:firstHero onSuccess:^(NSArray *movies) {
        NSLog(@"List of movies:%@", movies);
        XCTAssert([movies count] > 0, @"Could not obtain any movies.");
        [contentService fetchMovieDetailFor:movies[0] onSuccess:^(MovieDetail *movieDetail) {
            NSLog(@"Detail of first movie:%@", [movieDetail description]);
            XCTAssert(movieDetail.Plot && [movieDetail.Plot length] > 0, @"Could not obtain movie detail, plot.");
            [expectation fulfill];
        } onError:^(NSString *message) {
            NSLog(@"Opps, our hero seems to offline today...(%@)", message);
        }];
    } onError:^(NSString *message) {
        NSLog(@"Opps, our hero failed to do his work today...(%@)", message);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
