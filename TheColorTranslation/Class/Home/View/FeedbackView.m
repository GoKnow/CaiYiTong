//
//  FeedbackView.m
//  LoanPlatform
//
//  Created by Rain on 2017/12/11.
//  Copyright © 2017年 Rain. All rights reserved.
//

#import "FeedbackView.h"

@interface FeedbackView() <UITextViewDelegate>

@property (nonatomic ,strong) UILabel *labelPlaceholder;
@property (nonatomic ,strong) UITextView *textViewFeedBack;

@end
@implementation FeedbackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithRed:(237)/255.0 green:(237)/255.0 blue:(237)/255.0 alpha:1.0];
    
    UILabel *labelPropmt = [[UILabel alloc] init];
    labelPropmt.textColor = [UIColor grayColor];
    labelPropmt.font = [UIFont systemFontOfSize:15];
    labelPropmt.text = @"请输入您的宝贵意见:";
    [self addSubview:labelPropmt];
    [labelPropmt mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@10);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@30);
    }];
    
    UIView *viewBg = [[UIView alloc] init];
    viewBg.backgroundColor = [UIColor whiteColor];
    [self addSubview:viewBg];
    [viewBg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(labelPropmt.bottom).offset(@5);
        make.height.equalTo(@180);
    }];
    
    self.textViewFeedBack = [[UITextView alloc] init];
    self.textViewFeedBack.font = [UIFont systemFontOfSize:15];
    self.textViewFeedBack.textColor = [UIColor grayColor];
    self.textViewFeedBack.delegate = self;
    self.textViewFeedBack.returnKeyType = UIReturnKeyDone;
    [self addSubview:self.textViewFeedBack];
    [self.textViewFeedBack mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(labelPropmt.bottom).offset(@5);
        make.height.equalTo(@180);
    }];

    UIButton *buttonSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSubmit.backgroundColor = [UIColor whiteColor];
    [buttonSubmit setTitle:@"提交" forState:UIControlStateNormal];
    [buttonSubmit setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    buttonSubmit.titleLabel.font = [UIFont systemFontOfSize:15];
    [buttonSubmit addTarget:self action:@selector(onActionSubmit) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonSubmit];
    [buttonSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.textViewFeedBack.bottom).offset(@10);
        make.height.equalTo(@40);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
    }];
}

- (void)onActionSubmit
{
    if (self.textViewFeedBack.text.length == 0) {
        
        [LCProgressHUD showInfoMsg:@"请输入反馈内容!"];
        return;
    }
    if (self.blockSubmit) {
        
        self.blockSubmit(self.textViewFeedBack.text);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];

        return NO;
    }
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
