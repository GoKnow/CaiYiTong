//
//  LeftView.h
//  TheColorFor
//
//  Created by Rain on 2017/12/16.
//  Copyright © 2017年 Rain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftView : UIView

@property (nonatomic ,copy) void(^blockSelectRow)(NSInteger iRow);
@end
