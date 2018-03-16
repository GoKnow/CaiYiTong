//
//  LanguageViewController.h
//  TheColorTranslation
//
//  Created by Rain on 2017/12/19.
//  Copyright © 2017年 Rain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LanguageViewController : UIViewController

@property (nonatomic ,assign) BOOL bHaveAuto;

@property (nonatomic ,copy) void(^blockComplect)(NSString *strName ,NSString *strShorthand);
@end
