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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pickMovie:(id)selector {
    // TODO make selection logic here
    
    // present movie detail, push it onto the 'navigation stack'
    [self.navigationController pushViewController:[_assembly movieDetailViewController] animated:YES];
}

- (IBAction)selectHero:(id)selector {
    // present hero selection screen, push it onto the 'navigation stack'
    [self.navigationController pushViewController:[_assembly heroSelectorViewController] animated:YES];
}

@end
