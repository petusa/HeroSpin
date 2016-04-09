//
//  ViewController.m
//  HeroSpin
//
//  Created by Peter Nagy on 05/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import "MoviePickerViewController.h"
#import "AppAssembly.h"
#import "ContentService.h"
#import "RootViewController.h"
#import "RootViewController.h"
#import "AppModel.h"
#import "Hero.h"
#import "AnimationUtils.h"

@interface MoviePickerViewController ()
{
    AppAssembly *_assembly;
    id<ContentService> _contentService;
    AppModel *_appModel;
    MoviePickerUIState _uiState;
    CGPoint _heroSpinButtonOriginalPosition;
    CGPoint _selectedHeroImageOriginalPosition;
}
@end

@implementation MoviePickerViewController

- (instancetype)initWithAssembly:(AppAssembly *)assembly
{
    self = [super init];
    if (self)
    {
        _assembly = assembly;
        _contentService = assembly.contentService;
        _appModel = assembly.appModel;
        _uiState = MoviePickerUIStateInitial;
        
    }
    return self;
}

//-------------------------------------------------------------------------------------------
#pragma mark - User interaction handling
//-------------------------------------------------------------------------------------------

- (IBAction)pickMovie:(id)sender
{
    NSLog(@"pickMovie clicked...");
    [_assembly.rootViewController pushViewController:[_assembly movieDetailViewController]];
}


- (IBAction)selectHero:(id)sender
{
    NSLog(@"selectHero clicked...");
    [[_assembly rootViewController] toggleSideViewController];
}

- (IBAction)reset:(id)sender
{
    NSLog(@"reset");
    _appModel.SelectedHero = nil;
    [self checkOrUpdateStateAndUI];
}

//-------------------------------------------------------------------------------------------
#pragma mark - Overridden View Methods
//-------------------------------------------------------------------------------------------

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    NSLog(@"viewWillLayoutSubviews");
}

- (void)viewDidLoad
{
    NSLog(@"view DId Load.... MoviePicker...");
    
    [super viewDidLoad];
    _heroSpinButtonOriginalPosition = _heroSpinButton.layer.position;
    _selectedHeroImageOriginalPosition  = _selectedHeroImage.layer.position;
    NSLog(@"viewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    [self checkOrUpdateStateAndUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkOrUpdateStateAndUI
{
    MoviePickerUIState currentState = _uiState;
    switch (currentState) {
        case MoviePickerUIStateInitial:
            if (_assembly.appModel.SelectedHero) {
                _selectedHeroImage.image = [UIImage imageNamed:_appModel.SelectedHero.imagePath];
                [self animateToMovieSelectionState];
                _uiState = MoviePickerUIStateHeroSelected;
            } else {
                [self initialState];
            }
            break;
        case MoviePickerUIStateHeroSelected:
            if (_assembly.appModel.SelectedHero) {
                self.selectedHeroImage.image = [UIImage imageNamed:_appModel.SelectedHero.imagePath];
            } else {
                // reset clicked??
                [self initialState];
                _uiState = MoviePickerUIStateInitial;
            }
            break;
        default:
            break;
    }
}

- (void)initialState
{
    _selectedHeroImage.layer.position = _selectedHeroImageOriginalPosition;

    _selectedHeroImage.hidden = YES;
    
    _heroSpinButton.layer.position = _heroSpinButtonOriginalPosition;
    [self prepareHeroSpinButton];
    
    _resetButton.hidden = YES;
}


- (void)animateToMovieSelectionState
{
    [AnimationUtils changeLayerPositionWithAnimation:_heroSpinButton.layer verticalYDelta:140.0];
    
    _selectedHeroImage.hidden = NO;
    _selectedHeroImage.layer.position = CGPointMake(_selectedHeroImage.layer.position.x, _selectedHeroImageOriginalPosition.y - _selectedHeroImage.bounds.size.height);
    [AnimationUtils changeLayerPositionWithAnimation:_selectedHeroImage.layer verticalYDelta:_selectedHeroImage.bounds.size.height];
    
    _resetButton.hidden = NO;
    
}


- (void)prepareHeroSpinButton
{
    UIButton *_button = _heroSpinButton;
    _button.translatesAutoresizingMaskIntoConstraints = YES;
}

@end
