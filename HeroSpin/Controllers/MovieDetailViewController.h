//
//  MovieDetailViewController.h
//  HeroSpin
//
//  Created by Peter Nagy on 05/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContentService;
@class AppModel;

@interface MovieDetailViewController : UIViewController

- (instancetype)initWithContentService:(id<ContentService>)contentService appModel:(AppModel*)appModel;

@end
