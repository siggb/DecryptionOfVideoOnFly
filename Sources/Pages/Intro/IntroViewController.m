//
//  IntroViewController.m
//  KeenListener
//
//  Created by Ildar Sibagatov on 02.07.14.
//  Copyright (c) 2014 Sig Inc. All rights reserved.
//

#import "IntroViewController.h"

#define LOG_ON 1
static const CGFloat TimeoutBeforeStart = 1.5f;

@interface IntroViewController()

@property (nonatomic, weak) IBOutlet UILabel *versionLabel;

@end


@implementation IntroViewController

#pragma mark - View Lifecicle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.layer.masksToBounds = YES;
    
    // настраиваем строку с указанием версии текущей сборки
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [info objectForKey:@"CFBundleShortVersionString"];
    NSString *app_version = [NSString stringWithFormat:@"%@.%@", version, GIT_SHA_VERSION];
    [self.versionLabel setText:[NSString stringWithFormat:@"Version %@", app_version]];
    
    // запускаем логику по таймауту
    [NSTimer scheduledTimerWithTimeInterval:TimeoutBeforeStart target:self
                                   selector:@selector(startLogic) userInfo:nil repeats:NO];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    DPLog(LOG_ON, @"");
}

#pragma mark - Основная логика работы

/**
 *  Переход к основному экрану приложения
 */
- (void)startLogic
{
    [self performSegueWithIdentifier:@"IntroToMainID" sender:self];
}

@end
