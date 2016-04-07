//
//  AppAssembly.m
//  HeroSpin
//
//  Created by Peter Nagy on 06/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import "AppAssembly.h"
#import "AppDelegate.h"
#import "MoviePickerViewController.h"
#import "MovieDetailViewController.h"
#import "HeroSelectorViewController.h"


//TEMPORARILY ADDING A DUMMY SERVICE TO MAKE THE CODE COMPILABLE
#import "ContentService.h"

@interface DummyContentService : NSObject<ContentService>

@end

@implementation DummyContentService

- (void)fetchHeroes { NSLog(@"fetching heroes..."); }

- (void)fetchMoviesFor:(Hero*)hero
             onSuccess:(FetchMoviesReceivedBlock)successBlock
               onError:(FetchMoviesErrorBlock)errorBlock {}

- (void)fetchMovieDetailFor:(Movie*)movie
                  onSuccess:(FetchMoviesErrorBlock)successBlock
                    onError:(FetchMoviesErrorBlock)errorBlock {}

@end
//END OF TEMPORARY CODE
// TODO replace the above with header import pointing to a proper impl class for ContentService


@implementation AppAssembly

- (AppDelegate*)appDelegate
{
    return [TyphoonDefinition withClass:[AppDelegate class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(mainViewController) with:[self moviePickerViewController]];
    }];
}

- (UIViewController*)moviePickerViewController
{
    return [TyphoonDefinition withClass:[MoviePickerViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithAssembly:) parameters:^(TyphoonMethod *initializer)
         {
             [initializer injectParameterWith:self];
         }];
        definition.scope = TyphoonScopeSingleton;
    }];
}

- (UIViewController*)movieDetailViewController
{
    return [TyphoonDefinition withClass:[MovieDetailViewController class] configuration:^(TyphoonDefinition *definition) {}];
}

- (UIViewController*)heroSelectorViewController
{
    return [TyphoonDefinition withClass:[HeroSelectorViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithContentService:) parameters:^(TyphoonMethod *initializer)
         {
             [initializer injectParameterWith:[self contentService]];
         }];
    }];
}

- (id<ContentService>)contentService
{
    return [TyphoonDefinition withClass:[DummyContentService class] configuration:^(TyphoonDefinition *definition) {
        definition.scope = TyphoonScopeSingleton;
    }];
}

@end