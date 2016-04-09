//
//  RootViewController.h
//  HeroSpin
//
//  Created by Peter Nagy on 09/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaperFoldView.h"
#import "AppAssembly.h"

// Credit: code parts, inspiration taken from PocketForecast sample code, provided by Tyhoonframework creators

typedef enum {
    SideViewStateHidden,
    SideViewStateShowing
} SideViewState;

@interface RootViewController : UIViewController <PaperFoldViewDelegate>

@property(nonatomic, strong) PaperFoldView *view;

- (instancetype)initWithMainContentViewController:(UIViewController *)mainContentViewController assembly:(AppAssembly *)assembly;

- (void)pushViewController:(UIViewController *)viewController;

- (void)toggleSideViewController;

@end
