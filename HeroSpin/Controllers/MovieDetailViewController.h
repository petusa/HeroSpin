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

@property (nonatomic, strong) IBOutlet UIImageView *PosterImageView;
@property (nonatomic, strong) IBOutlet UILabel *TitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *PlotLabel;
@property (nonatomic, strong) IBOutlet UILabel *ActorsLabel;
@property (nonatomic, strong) IBOutlet UILabel *Duration;

@property (nonatomic, strong) IBOutlet UIScrollView *ScrollView;
@property (nonatomic, strong) IBOutlet UIView *ContentView;

- (instancetype)initWithContentService:(id<ContentService>)contentService appModel:(AppModel*)appModel;

@end
