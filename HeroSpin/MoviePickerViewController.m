//
//  ViewController.m
//  HeroSpin
//
//  Created by Peter Nagy on 05/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import "MoviePickerViewController.h"
#import "MovieDetailViewController.h"
#import "HeroSelectorViewController.h"

@interface MoviePickerViewController ()

@end

@implementation MoviePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pickMovie:(id)selector {
    MovieDetailViewController *nextViewController = [[MovieDetailViewController alloc] init];
    // and push it onto the 'navigation stack'
    [self.navigationController pushViewController:nextViewController animated:YES];
}

- (IBAction)selectHero:(id)selector {
    HeroSelectorViewController *nextViewController = [[HeroSelectorViewController alloc] init];
    // and push it onto the 'navigation stack'
    [self.navigationController pushViewController:nextViewController animated:YES];
}

@end
