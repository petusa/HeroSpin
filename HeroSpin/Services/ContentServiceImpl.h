//
//  ContentServiceImpl.h
//  HeroSpin
//
//  Created by Peter Nagy on 06/04/16.
//  Copyright © 2016 Peter Nagy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentService.h"

@protocol ContentService;

@interface ContentServiceImpl :  NSObject<ContentService>

@property(nonatomic, strong) NSURL* serviceUrl;

@end
