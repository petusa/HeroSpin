//
//  HeroSelectorViewController.m
//  HeroSpin
//
//  Created by Peter Nagy on 05/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import "HeroSelectorViewController.h"
#import "ContentService.h"

@interface HeroSelectorViewController ()
{
    id<ContentService> _contentService;
}
@end

@implementation HeroSelectorViewController

- (instancetype)initWithContentService:(id<ContentService>)contentService
{
    self = [super init];
    if (self)
    {
        _contentService = contentService;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pickMovie:(id)selector {
    // and pop it from the 'navigation stack' to navigate back
    [self.navigationController popViewControllerAnimated:YES];
}

@end
