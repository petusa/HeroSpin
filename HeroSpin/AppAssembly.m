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
    return [TyphoonDefinition withClass:[HeroSelectorViewController class] configuration:^(TyphoonDefinition *definition) {}];
}

@end
