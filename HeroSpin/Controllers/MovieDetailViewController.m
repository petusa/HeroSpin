//
//  MovieDetailViewController.m
//  HeroSpin
//
//  Created by Peter Nagy on 05/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "AppModel.h"
#import "MovieDetail.h"

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    MovieDetail *md = _appModel.SelectedMovieDetail;
    self.PosterImageView.image = [self loadImagefrom:md.Poster];
    self.TitleLabel.text = [NSString stringWithFormat:@"%@ (%d)", md.Title, md.Year];
    self.PlotLabel.text = md.Plot;
    self.Duration.text = md.Runtime;
    self.ActorsLabel.text = md.Actors;
}

- (UIImage*)loadImagefrom:(NSURL *)url
{
    if (!url) {
        // TODO add some default placeholder image here...
        return nil;
    }
    // replace to HTTPS in case it was http
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    components.scheme = @"https";
    NSData *data = [NSData dataWithContentsOfURL:components.URL];
    UIImage *img = [[UIImage alloc] initWithData:data];
    return img;
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
