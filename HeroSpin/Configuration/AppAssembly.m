//
//  AppAssembly.m
//  HeroSpin
//
//  Created by Peter Nagy on 06/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import "AppAssembly.h"
#import "AppDelegate.h"
#import "RootViewController.h"
#import "MoviePickerViewController.h"
#import "MovieDetailViewController.h"
#import "HeroSelectorViewController.h"
#import "ContentServiceImpl.h"
#import "Typhoon.h"

@implementation AppAssembly

- (AppDelegate*)appDelegate
{
    return [TyphoonDefinition withClass:[AppDelegate class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(rootViewController) with:[self rootViewController]];
    }];
}

- (UIViewController*)rootViewController
{
    return [TyphoonDefinition withClass:[RootViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithMainContentViewController:assembly:) parameters:^(TyphoonMethod *initializer)
         {
             [initializer injectParameterWith:self.moviePickerViewController];
             [initializer injectParameterWith:self];
         }];
         definition.scope = TyphoonScopeSingleton;
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
    return [TyphoonDefinition withClass:[ContentServiceImpl class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(serviceUrl) with:TyphoonConfig(@"service.url")];
        definition.scope = TyphoonScopeSingleton;
    }];
}

- (id)config
{
    return [TyphoonDefinition withConfigName:@"Configuration.plist"];
}

@end