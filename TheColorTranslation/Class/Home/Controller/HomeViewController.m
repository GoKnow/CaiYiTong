//
//  HomeViewController.m
//  TheColorTranslation
//
//  Created by Rain on 2017/12/19.
//  Copyright © 2017年 Rain. All rights reserved.
//

#import "HomeViewController.h"
#import "LanguageViewController.h"
#import "LeftView.h"
#import "NSString+Hashing.h"
#import "AboutUsViewController.h"
#import "FeedbackViewController.h"

@interface HomeViewController ()

@property (nonatomic ,strong) LeftView *viewLeft;
@property (nonatomic ,strong) UITextView *textViewInput;
@property (nonatomic ,strong) UITextView *textViewOutput;

@property (nonatomic ,copy) NSString *strNameInput;
@property (nonatomic ,copy) NSString *strShorthandInput;
@property (nonatomic ,copy) NSString *strNameOutput;
@property (nonatomic ,copy) NSString *strShorthandOutput;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.strNameInput = @"自动检测";
    self.strShorthandInput = @"auto";
    self.strNameOutput = @"中文";
    self.strShorthandOutput = @"zh";

    [self constructUI];
}

- (void)constructUI
{
    self.view.backgroundColor = STCOLORA(243, 243, 243, 1.0);
    self.fd_prefersNavigationBarHidden = YES;
    
    UIImageView *imageViewBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAV_BAR_HEIGHT)];
    imageViewBg.backgroundColor = STCOLORA(42, 191, 134, 1.0);
    imageViewBg.userInteractionEnabled = YES;
    [self.view addSubview:imageViewBg];
    
    UIImageView *imageViewTip = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 10, 31, 20, 20)];
    imageViewTip.image = [UIImage imageNamed:@"icon_arrow_right"];
    [imageViewBg addSubview:imageViewTip];
    
    for (NSInteger i = 0; i < 2; i ++) {
        
        UIButton *buttonTop = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTop.frame = CGRectMake((i == 0? (CGRectGetMinX(imageViewTip.frame) - 90): (CGRectGetMaxX(imageViewTip.frame) + 10)), 27, 80, 30);
        buttonTop.titleLabel.font = [UIFont systemFontOfSize:13];
        buttonTop.backgroundColor = [UIColor whiteColor];
        [buttonTop setTitleColor:STCOLORA(42, 191, 134, 1.0) forState:UIControlStateNormal];
        buttonTop.tag = 1000 + i;
        buttonTop.layer.cornerRadius = 3.0;
        buttonTop.layer.masksToBounds = YES;
        [buttonTop setTitle:@[@"自动检测",@"中文"][i] forState:UIControlStateNormal];
        [buttonTop addTarget:self action:@selector(onActionTop:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonTop];
    }
    
    UIButton *buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLeft.frame = CGRectMake(10, 22, 40, 40);
    [buttonLeft setImage:[UIImage imageNamed:@"icon_list"] forState:UIControlStateNormal];
    [buttonLeft addTarget:self action:@selector(onActionbuttonLeft) forControlEvents:UIControlEventTouchUpInside];
    [imageViewBg addSubview:buttonLeft];
    
    self.textViewInput = [[UITextView alloc] initWithFrame:CGRectMake(10, NAV_BAR_HEIGHT + 10, SCREEN_WIDTH - 20, 150)];
    self.textViewInput.layer.cornerRadius = 5.0;
    self.textViewInput.layer.masksToBounds = YES;
    self.textViewInput.font = [UIFont systemFontOfSize:15];
    self.textViewInput.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textViewInput];
    
    for (NSInteger i = 0; i < 2; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((i == 1? (SCREEN_WIDTH - 70): 10), CGRectGetMaxY(self.textViewInput.frame) + 10, 60, 35);
        [button setTitle:@[@"复制",@"翻译"][i] forState:UIControlStateNormal];
        button.backgroundColor = STCOLORA(42, 191, 134, 1.0);
        button.layer.cornerRadius = 3.0;
        button.layer.masksToBounds = YES;
        button.tag = 10 + i;
        [button addTarget:self action:@selector(onActionFunction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    CGFloat fX = CGRectGetMaxY(self.textViewInput.frame) + 55;
    self.textViewOutput = [[UITextView alloc] initWithFrame:CGRectMake(10, fX, SCREEN_WIDTH - 20, SCREEN_HEIGHT - 10 - fX)];
    self.textViewOutput.layer.cornerRadius = 5.0;
    self.textViewOutput.layer.masksToBounds = YES;
    self.textViewOutput.font = [UIFont systemFontOfSize:15];
    self.textViewOutput.backgroundColor = [UIColor whiteColor];
    self.textViewOutput.userInteractionEnabled = NO;
    [self.view addSubview:self.textViewOutput];
    
}

- (void)onActionbuttonLeft
{
    STWeakSelf;
    self.viewLeft = [[LeftView alloc] initWithFrame:CGRectMake(0, 0, 200, SCREEN_HEIGHT)];
    self.zh_popupController = [[zhPopupController alloc] init];
    self.zh_popupController.slideStyle = zhPopupSlideStyleFromLeft;
    self.zh_popupController.layoutType = zhPopupLayoutTypeLeft;
    self.zh_popupController.allowPan = YES;
    [self.zh_popupController presentContentView:self.viewLeft duration:0.1 springAnimated:NO];
    
    self.viewLeft.blockSelectRow = ^(NSInteger iRow) {
        
        [weakSelf.zh_popupController dismiss];
        
        if (iRow == 0) {
            
            FeedbackViewController *vc = [[FeedbackViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else if (iRow == 1){
            
            AboutUsViewController *vc = [[AboutUsViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
    };
}

- (void)onActionFunction:(UIButton *)sender
{
    if (sender.tag == 10) {
       
        [LCProgressHUD showSuccess:@"复制成功!"];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.textViewOutput.text;
        
    }else if (sender.tag == 11){
        
        [self requestData];
    }
}

- (void)onActionTop:(UIButton *)sender
{
    STWeakSelf;
    BOOL bHaveAuto = NO;
    if (sender.tag == 1000) {
        
        bHaveAuto = YES;
    }
    LanguageViewController *vc = [[LanguageViewController alloc] init];
    vc.bHaveAuto = bHaveAuto;
    [self.navigationController pushViewController:vc animated:YES];
    vc.blockComplect = ^(NSString *strName, NSString *strShorthand) {
        
        UIButton *button1 = (UIButton *)[self.view viewWithTag:1000];
        UIButton *button2 = (UIButton *)[self.view viewWithTag:1001];

        if (bHaveAuto) {
            
            weakSelf.strNameInput = strName;
            weakSelf.strShorthandInput = strShorthand;
            [button1 setTitle:strName forState:UIControlStateNormal];

        }else{
            weakSelf.strNameOutput = strName;
            weakSelf.strShorthandOutput = strShorthand;
            [button2 setTitle:strName forState:UIControlStateNormal];
        }
    };
}

- (void)requestData
{
    [LCProgressHUD showLoading:@"翻译中..."];
    STWeakSelf;
    if (self.textViewInput.text.length == 0)
    
    {
        
        [LCProgressHUD showInfoMsg:@"请输入需要转换的文本内容!"];
        return;
    }
    
    NSString *strAppID = @"20171219000106415";
    NSString *strSalt = [NSString stringWithFormat:@"%d",rand()];
    NSString *strMiYao = @"VgNj_wEL2thlgIFvnLCI";
    NSString *strSign = [NSString stringWithFormat:@"%@%@%@%@",strAppID ,self.textViewInput.text,strSalt,strMiYao];
    NSString *strUrl = [NSString stringWithFormat:@"https://api.fanyi.baidu.com/api/trans/vip/translate?q=%@&from=%@&to=%@&appid=%@&salt=%@&sign=%@",[self.textViewInput.text URLEncode],[self.strShorthandInput URLEncode],[self.strShorthandOutput URLEncode],[strAppID URLEncode],[strSalt URLEncode],[[strSign MD5Hash] URLEncode]];
    
    [[NetWorkingManager sharedManager] getResultWithParameter:nil url:strUrl progress:nil blockFinish:^(id responseObject, ResultCode resultCode, NSString *resultMessage) {
        
        NSLog(@"%@",responseObject);
        if ([[responseObject allKeys] containsObject:@"trans_result"])
        {
            if ([responseObject[@"trans_result"] count]) {
                
                weakSelf.textViewOutput.text = responseObject[@"trans_result"][0][@"dst"];
            }
            [LCProgressHUD hide];
        }else
        {
            [LCProgressHUD showFailure:@"请重试"];
        }
    }];
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

@end
