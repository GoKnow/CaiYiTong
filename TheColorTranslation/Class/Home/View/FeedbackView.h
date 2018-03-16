//
//  FeedbackView.h
//  LoanPlatform
//
//  Created by Rain on 2017/12/11.
//  Copyright © 2017年 Rain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackView : UIView

@property (nonatomic ,copy) void(^blockSubmit)(NSString *strContent);
@end
