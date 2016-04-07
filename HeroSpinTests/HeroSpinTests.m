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
    Hero* Batman = [Hero withName:@"Batman" image:@"batman.jpg"];
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

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
