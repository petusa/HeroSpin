//
//  HeroSelectorViewController.h
//  HeroSpin
//
//  Created by Peter Nagy on 05/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@protocol ContentService;

@interface HeroSelectorViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) IBOutlet iCarousel *carousel;

- (instancetype)initWithContentService:(id<ContentService>)contentService;

@end
