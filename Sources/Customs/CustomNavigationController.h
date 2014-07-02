//
//  CustomNavigationController.h
//  KeenListener
//
//  Created by Ildar Sibagatov on 02.07.14.
//  Copyright (c) 2014 Sig Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Модифицированный UINavigationController,
 оптимизированный под работу в заданных ориентациях.
 
 Поддерживаемые ориентации задаются
 корневым контроллером данного UINavigationController.
 
 Рекомендуется к использованию в iOS 5.0 и выше.
 */

@interface CustomNavigationController : UINavigationController

/** @name Данные методы необходимо определить в классе корневого контроллера */
- (BOOL)shouldAutorotate;
- (NSUInteger)supportedInterfaceOrientations;
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation;

@end
