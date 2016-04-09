//
//  ViewController.h
//  HeroSpin
//
//  Created by Peter Nagy on 05/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppAssembly;

typedef enum {
    MoviePickerUIStateInitial,
    MoviePickerUIStateHeroSelected
} MoviePickerUIState;

@interface MoviePickerViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *heroSpinButton;
@property (nonatomic, strong) IBOutlet UIButton *heroSelectorButton;
@property (nonatomic, strong) IBOutlet UIButton *resetButton;
@property (nonatomic, strong) IBOutlet UIImageView *selectedHeroImage;

- (instancetype)initWithAssembly:(AppAssembly *)assembly;

@end

