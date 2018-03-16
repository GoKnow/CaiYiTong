//
//  Header.h
//  TheColorTranslation
//
//  Created by Rain on 2017/12/19.
//  Copyright © 2017年 Rain. All rights reserved.
//

#ifndef Header_h
#define Header_h

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"
#import "LCProgressHUD.h"
#import "IQKeyboardManager.h"
#import "NetWorkingManager.h"
#import "zhPopupController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

#define NAV_BAR_HEIGHT 64


#define STCOLORA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]


#define STWeakSelf __weak typeof(self) weakSelf = self;

#define STRING_HEIGHT(string ,fWidth ,fFontSize) [string boundingRectWithSize:CGSizeMake(fWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fFontSize]} context:nil].size

#endif /* Header_h */
