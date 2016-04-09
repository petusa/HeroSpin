//
//  MovieDetailViewController.m
//  HeroSpin
//
//  Created by Peter Nagy on 05/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()
{
    id<ContentService> _contentService;
    AppModel *_appModel;
}
@end

@implementation MovieDetailViewController

- (instancetype)initWithContentService:(id<ContentService>)contentService appModel:(AppModel*)appModel
{
    self = [super init];
    if (self)
    {
        _contentService = contentService;
        _appModel = appModel;
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

- (IBAction)pickAnotherMovie:(id)selector {
    // and pop it from the 'navigation stack' to navigate back
    [self.navigationController popViewControllerAnimated:YES];
}

@end
