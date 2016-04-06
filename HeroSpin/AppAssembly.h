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
@protocol ContentService;

@interface AppAssembly : TyphoonAssembly

- (AppDelegate*)appDelegate;

- (UIViewController*)moviePickerViewController;

- (UIViewController*)movieDetailViewController;

- (UIViewController*)heroSelectorViewController;

@end
