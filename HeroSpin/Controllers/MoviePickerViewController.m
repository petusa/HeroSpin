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

@interface MoviePickerViewController ()
{
    AppAssembly *_assembly;
    id<ContentService> _contentService;
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
    NSLog(@"reset clicked...");
    
}

@end
