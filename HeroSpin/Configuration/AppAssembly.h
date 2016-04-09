//
//  AppAssembly.h
//  HeroSpin
//
//  Created by Peter Nagy on 06/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Typhoon/TyphoonAssembly.h>

@class AppDelegate;
@class UIViewController;
@class RootViewController;
@protocol ContentService;

@interface AppAssembly : TyphoonAssembly

- (AppDelegate*)appDelegate;

- (RootViewController*)rootViewController;

- (UIViewController*)moviePickerViewController;

- (UIViewController*)movieDetailViewController;

- (UIViewController*)heroSelectorViewController;

- (id<ContentService>)contentService;

@end
