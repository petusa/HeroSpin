//
//  RootViewController.m
//  HeroSpin
//
//  Created by Peter Nagy on 09/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import "RootViewController.h"

#define SIDE_CONTROLLER_WIDTH 245.0

@interface RootViewController ()
{
    UINavigationController *_navigator;
    UIView *_mainContentViewContainer;
    SideViewState _sideViewState;
    UIViewController *_sideViewController;
    AppAssembly *_assembly;
}
@end

@implementation RootViewController

@dynamic view;

//-------------------------------------------------------------------------------------------
#pragma mark - Initialization & Destruction
//-------------------------------------------------------------------------------------------

- (instancetype)initWithMainContentViewController:(UIViewController *)mainContentViewController assembly:(AppAssembly *)assembly
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _assembly = assembly;
        _sideViewState = SideViewStateHidden;
        if (mainContentViewController) {
            [self pushViewController:mainContentViewController replaceRoot:YES];
        }
        // TODO remove this below line - temorarily showing sideviewcontroller at init, while implementing heroselector
        [self toggleSideViewController];
    }
    return self;
}

- (id)init
{
    return [self initWithMainContentViewController:nil assembly:nil];
}

//-------------------------------------------------------------------------------------------
#pragma mark - Interface Methods
//-------------------------------------------------------------------------------------------

- (void)pushViewController:(UIViewController *)viewController
{
    [self pushViewController:viewController replaceRoot:NO];
}

- (void)pushViewController:(UIViewController *)viewController replaceRoot:(BOOL)replaceRoot
{
    @synchronized (self) {
        if (!_navigator) {
            [self makeNavigationControllerWithRoot:viewController];
        } else if (replaceRoot) {
            [_navigator setViewControllers:@[viewController] animated:YES];
        } else {
            [_navigator pushViewController:viewController animated:YES];
        }
    }
}

- (void)toggleSideViewController
{
    if (_sideViewState == SideViewStateHidden) {
        [self showSideViewController];
    } else if (_sideViewState == SideViewStateShowing) {
        [self dismissSideViewController];
    }
}

//-------------------------------------------------------------------------------------------
#pragma mark - Private/Helper Methods
//-------------------------------------------------------------------------------------------

- (void)showSideViewController
{
    if (_sideViewState != SideViewStateShowing) {
        _sideViewState = SideViewStateShowing;
        // TODO shall we always recreated it?
        _sideViewController = [_assembly heroSelectorViewController];
        CGRect sideFrameRect = CGRectMake(0, 0,
                                      _mainContentViewContainer.frame.size.width - (_mainContentViewContainer.frame.size.width - SIDE_CONTROLLER_WIDTH), _mainContentViewContainer.frame.size.height);
        [_sideViewController.view setFrame:sideFrameRect];
        [self.view setDelegate:self];
        [self.view setLeftFoldContentView:_sideViewController.view foldCount:5 pullFactor:0.9];
        [self.view setPaperFoldState:PaperFoldStateLeftUnfolded];
        
        [_mainContentViewContainer setNeedsDisplay];
    }
}

- (void)dismissSideViewController
{
    if (_sideViewState != SideViewStateHidden) {
        _sideViewState = SideViewStateHidden;
        [self.view setPaperFoldState:PaperFoldStateDefault];
        [_navigator.topViewController viewWillAppear:YES];
    }
}

- (void)makeNavigationControllerWithRoot:(UIViewController *)root
{
    _navigator = [[UINavigationController alloc] initWithRootViewController:root];
    _navigator.navigationBarHidden = YES;
    _navigator.view.frame = self.view.bounds;
    [_mainContentViewContainer addSubview:_navigator.view];
}

//-------------------------------------------------------------------------------------------
#pragma mark - <PaperFoldViewDelegate>
//-------------------------------------------------------------------------------------------

- (void)paperFoldView:(id)paperFoldView didFoldAutomatically:(BOOL)automated toState:(PaperFoldState)paperFoldState
{
    if (paperFoldState == PaperFoldStateDefault) {
        [_navigator.topViewController viewDidAppear:YES];
        //We could set the left-side view to nil here, however Paper-fold does not like an empty view at this point
        UIView *dummyView = [[UIView alloc] initWithFrame:CGRectMake(1, 1, 1, 1)];
        [(PaperFoldView *) self.view setLeftFoldContentView:dummyView foldCount:0 pullFactor:0];
        // TODO shall we always free it up?
        _sideViewController = nil;
    }
}

//-------------------------------------------------------------------------------------------
#pragma mark - Overridden Methods
//-------------------------------------------------------------------------------------------

- (void)loadView
{
    CGRect screen = [UIScreen mainScreen].bounds;
    self.view = [[PaperFoldView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height)];
    
    [self.view setTimerStepDuration:0.02];
    
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
    _mainContentViewContainer = [[UIView alloc] initWithFrame:self.view.bounds];
    [_mainContentViewContainer setBackgroundColor:[UIColor blackColor]];
    [self.view setCenterContentView:_mainContentViewContainer];
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [_mainContentViewContainer setFrame:self.view.bounds];
    [_navigator.view setFrame:_mainContentViewContainer.bounds];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)shouldAutorotate
{
    UIViewController *topController = _navigator.topViewController;
    return [topController shouldAutorotate];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_navigator.topViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [_navigator.topViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

@end
