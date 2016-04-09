//
//  HeroSelectorViewController.m
//  HeroSpin
//
//  Created by Peter Nagy on 05/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import "HeroSelectorViewController.h"
#import "ContentService.h"
#import "AppModel.h"
#import "Hero.h"

@interface HeroSelectorViewController ()
{
    id<ContentService> _contentService;
    AppModel *_appModel;
    NSArray *_heroes;
    long _currentlySelectedIndex;
}
@end

@implementation HeroSelectorViewController

- (instancetype)initWithContentService:(id<ContentService>)contentService appModel:(AppModel*)appModel
{
    self = [super init];
    if (self)
    {
        _contentService = contentService;
        _appModel = appModel;
        _heroes = [_contentService fetchHeroes];
    }
    return self;
}

- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
}


- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    //this is true even if your project is using ARC, unless
    //you are targeting iOS 5 as a minimum deployment target
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
}

//-------------------------------------------------------------------------------------------
#pragma mark - View lifecycle
//-------------------------------------------------------------------------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    // additional setup after loading the view from its nib.
    
    //configure carousel
    _carousel.type = iCarouselTypeLinear;
    _carousel.vertical = YES;
    _carousel.clipsToBounds = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // free up memory by releasing subviews
    self.carousel = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-------------------------------------------------------------------------------------------
#pragma mark - iCarousel delegate methods
//-------------------------------------------------------------------------------------------

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [_heroes count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    // get current hero
    Hero *hero = (Hero*)_heroes[index];
    
    UILabel *label = nil;

        // create new view if no view is available for recycling
    if (view == nil) {
        
        CGRect frameSize = CGRectMake(0, 0, 220.0f, 220.0f);
        view = [[UIImageView alloc] initWithFrame:frameSize];
        ((UIImageView*)view).layer.cornerRadius = 110;
        ((UIImageView*)view).layer.masksToBounds = YES;
        view.contentMode = UIViewContentModeRedraw;
        
        // add opacity
        UIView *f = [[UIView alloc] initWithFrame:frameSize];
        f.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        f.userInteractionEnabled = NO;
        f.tag = 1;
        [view addSubview:f];
        [view sendSubviewToBack:f];
        
        CGRect labelFrameRect = CGRectMake(view.bounds.origin.x, view.bounds.origin.y+160, 220, 20);
        label = [[UILabel alloc] initWithFrame:labelFrameRect];
        label.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:24];
        label.tag = 2;
        [view addSubview:label];
    } else {
        // get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:2];
    }
    
    // to ensure that views are properly visualized
    if (index == _currentlySelectedIndex) {
        [self makeHeroViewSelected:view];
    } else {
        [self makeHeroViewUnSelected:view];
    }
    
    // replace hero image
    ((UIImageView *)view).image = [UIImage imageNamed:hero.imagePath];
    // replace hero name
    label.text = hero.name;
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1;
    }
    return value;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    if (_currentlySelectedIndex==index) return;
    
    // remove previous selection from old view
    [self makeHeroViewUnSelected:[carousel itemViewAtIndex:_currentlySelectedIndex]];
    
    // add current selection to new view
    [self makeHeroViewSelected:[carousel itemViewAtIndex:index]];
    // set current index
    _currentlySelectedIndex = index;
    
    // update application model
    _appModel.SelectedHero = _heroes[_currentlySelectedIndex];
}

- (void)makeHeroViewSelected:(UIView *)heroView {
    [heroView viewWithTag:2].backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
    [heroView viewWithTag:1].backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];

}

- (void)makeHeroViewUnSelected:(UIView *)heroView {
    [heroView viewWithTag:2].backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    [heroView viewWithTag:1].backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];

}



@end
