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
#import "Movie.h"
#import "MovieDetail.h"
#import "AnimationUtils.h"

@interface MoviePickerViewController ()
{
    AppAssembly *_assembly;
    id<ContentService> _contentService;
    AppModel *_appModel;
    MoviePickerUIState _uiState;
    CGPoint _heroSpinButtonOriginalPosition;
    CGPoint _selectedHeroContainerOriginalPosition;
    BOOL _firstLaunch;
}
@end

@implementation MoviePickerViewController

NSString *const PULSE_ANIMATION = @"PULSE_ANIMATION";
NSString *const RADAR_SIGNAL_ANIMATION = @"RADAR_SIGNAL_ANIMATION";

- (instancetype)initWithAssembly:(AppAssembly *)assembly
{
    self = [super init];
    if (self)
    {
        _assembly = assembly;
        _contentService = assembly.contentService;
        _appModel = assembly.appModel;
        _uiState = MoviePickerUIStateInitial;
        _firstLaunch = YES;
        
    }
    return self;
}

//-------------------------------------------------------------------------------------------
#pragma mark - User interaction handling
//-------------------------------------------------------------------------------------------

- (IBAction)pickMovie:(id)sender
{
    NSLog(@"pickMovie clicked...");
    _firstLaunch = NO;
    _footerView.hidden = NO;
    _startingHelperTextLabel.hidden = YES;
    if (_uiState == MoviePickerUIStateInitial) {
        // find hero first
        [self runSelectHeroLogic];
    } else {
        // search for movie
        [self runSelectMovieLogic];
    }
}

- (IBAction)selectHero:(id)sender
{
    NSLog(@"selectHero clicked...");
    _closeHeroSelectorButton.center = _heroSelectorButton.center;
    _closeHeroSelectorButton.hidden = _heroSelectorButton.hidden;
    _heroSelectorButton.hidden = !_closeHeroSelectorButton.hidden;
    [[_assembly rootViewController] toggleSideViewController];
}

- (IBAction)reset:(id)sender
{
    NSLog(@"reset clicked...");
    _appModel.SelectedHero = nil;
    [self checkOrUpdateStateAndUI];
    // in case the reset call comes from the error view
    self.errorView.hidden = YES;
    [AnimationUtils pause:PULSE_ANIMATION];
    [AnimationUtils pause:RADAR_SIGNAL_ANIMATION];
}

//-------------------------------------------------------------------------------------------
#pragma mark - Business logic
//-------------------------------------------------------------------------------------------

- (void)runSelectHeroLogic
{
    NSArray *heroes = [_contentService fetchHeroes];
    // TODO we should not know about how heroes and default/random hero are stored, here
    // maybe we should send it to contentService fetchRandomHero method
    NSInteger selectedHeroIndex = (arc4random() % ([heroes count]-1)) + 1;
    _appModel.SelectedHero = heroes[selectedHeroIndex];
    [self checkOrUpdateStateAndUI];
}

- (void)runSelectMovieLogic
{
    if (!_appModel.SelectedHero) {
        NSLog(@"Something wrong in app logic, we should have a hero selected at this point.");
        return;
    }
    [AnimationUtils start:PULSE_ANIMATION];
    [AnimationUtils start:RADAR_SIGNAL_ANIMATION];
    [_contentService fetchMoviesFor:_appModel.SelectedHero onSuccess:^(NSArray *movies) {
        // TODO find better remote service for finding movies
        // we must filter the results as there are many non appropriate movies, mostly without Poster
        // as based on WikiPedia, all Marvel movies are from 1986 and on, except for Captain America oldest version
        // so we also filter from the year 1986
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"Poster != nil && Year > 1985" ];
        NSArray *filteredMovies = [movies filteredArrayUsingPredicate:pred];
        if ([filteredMovies count] == 0) {
            // TODO handle this in lower level
            [self handleBusinessError:@"No appropriate movie found for hero."];
            return;
        }
        NSInteger selectedMovieIndex = arc4random() % [filteredMovies count];
        _appModel.SelectedMovie = filteredMovies[selectedMovieIndex];
        [_contentService fetchMovieDetailFor:_appModel.SelectedMovie onSuccess:^(MovieDetail *movieDetail) {
            _appModel.SelectedMovieDetail = movieDetail;
            [_appModel.PickedMoviesHistory addObject:movieDetail];
            NSLog(@"picked movie: %@", [movieDetail description]);
//            [AnimationUtils pause:PULSE_ANIMATION];
//            [AnimationUtils pause:RADAR_SIGNAL_ANIMATION];
            [_assembly.rootViewController pushViewController:[_assembly movieDetailViewController]];
        } onError:^(NSString *message) {
            [self handleBusinessError:message];
        }];
    } onError:^(NSString *message) {
        [self handleBusinessError:message];
    }];
}

- (void)handleBusinessError:(NSString*)message
{
    NSLog(@"It seems our heroes are experiencing some difficulties while saving the world...(%@)", message);
    self.errorView.hidden = NO;
    // TODO make full screen error view:
    // in case of COMMUNICATION_ERROR: Oops, it seems our heroes are offline today, check your phone's internet connection to reach them
    // in other cases: Oops, something catastophe happend, our heroes are working on recovey, check it later
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
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    _heroSpinButtonOriginalPosition = _heroSpinButton.layer.position;
    _selectedHeroContainerOriginalPosition  = _selectedHeroContainer.layer.position;
    [self prepareButtonBorderFor:_heroSelectorButton withColor:[UIColor redColor]];
    [self prepareButtonBorderFor:_resetButton withColor:[UIColor blackColor]];
    [self prepareButtonBorderFor:_closeHeroSelectorButton withColor:[UIColor blackColor]];
    [self prepareButtonBorderFor:_returnFromErrorButton withColor:[UIColor blackColor]];
    
    _footerView.hidden = YES;
    _startingHelperTextLabel.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    [self checkOrUpdateStateAndUI];
    [self prepareUIForAnimations]; // prepare animation nicely working
    _footerView.hidden = NO;
    _startingHelperTextLabel.hidden = YES;
    if (_firstLaunch) {
        _footerView.hidden = YES;
        _startingHelperTextLabel.hidden = NO;
    }
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
                _selectedHeroLabel.text = _appModel.SelectedHero.name;
                [self animateToMovieSelectionState];
                _uiState = MoviePickerUIStateHeroSelected;
            } else {
                [self initialState];
            }
            break;
        case MoviePickerUIStateHeroSelected:
            if (_assembly.appModel.SelectedHero) {
                self.selectedHeroImage.image = [UIImage imageNamed:_appModel.SelectedHero.imagePath];
                _selectedHeroLabel.text = _appModel.SelectedHero.name;
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
    _selectedHeroContainer.layer.position = _selectedHeroContainerOriginalPosition;
    _selectedHeroContainer.hidden = YES;
    
    _heroSpinButton.layer.position = _heroSpinButtonOriginalPosition;
    _heroSpinButton.center = self.view.center;
    
    _resetButton.hidden = YES;
    _helperTextLabel.hidden = YES;
    _errorView.hidden = YES;
    
    [AnimationUtils reset:PULSE_ANIMATION];
    [AnimationUtils reset:RADAR_SIGNAL_ANIMATION];
}

- (void)animateToMovieSelectionState
{
    // animate button
    [AnimationUtils changeLayerPositionWithAnimation:_heroSpinButton.layer verticalYDelta:120.0 withCompletionBlock:nil];
    
    // animate container
    _selectedHeroContainer.hidden = NO;
    _selectedHeroContainer.layer.position = CGPointMake(_selectedHeroContainer.layer.position.x, _selectedHeroContainerOriginalPosition.y - _selectedHeroContainer.bounds.size.height);
    [AnimationUtils changeLayerPositionWithAnimation:_selectedHeroContainer.layer verticalYDelta:_selectedHeroContainer.bounds.size.height withCompletionBlock:^{
        _resetButton.hidden = NO;
        _helperTextLabel.hidden = NO;
    }];
}

- (void)prepareUIForAnimations
{
    _selectedHeroContainer.translatesAutoresizingMaskIntoConstraints = YES;
    _heroSpinButton.translatesAutoresizingMaskIntoConstraints = YES; // to make translate work properly, disable auto layout
    [AnimationUtils addPulseAnimation:_heroSpinButton.imageView.layer withId:PULSE_ANIMATION];
    [AnimationUtils addRadarSignalAnimation:_heroSpinButton withId:RADAR_SIGNAL_ANIMATION];
    [AnimationUtils reset:PULSE_ANIMATION];
    [AnimationUtils reset:RADAR_SIGNAL_ANIMATION];
}

-(void)prepareButtonBorderFor:(UIButton*)button withColor:(UIColor*)color
{
    [button.layer setCornerRadius:button.bounds.size.width / 2.0];
    [button.layer setBorderWidth:2.0f];
    [button.layer setMasksToBounds:YES];
    [button.layer setBorderColor:color.CGColor];
}

@end
