//
//  FeedbackViewController.m
//  LoanPlatform
//
//  Created by Rain on 2017/12/8.
//  Copyright © 2017年 Rain. All rights reserved.
//

#import "FeedbackViewController.h"
#import "FeedbackView.h"

@interface FeedbackViewController ()

@property (nonatomic ,strong) FeedbackView *viewFeedback;
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self constructUI];
    
}

#pragma mark - 初始化

- (void)constructUI
{
    STWeakSelf;
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;

    UIImageView *imageViewBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAV_BAR_HEIGHT)];
    imageViewBg.userInteractionEnabled = YES;
    imageViewBg.backgroundColor = STCOLORA(42, 191, 134, 1.0);
    [self.view addSubview:imageViewBg];
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 100, 30, 200, 34)];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.font = [UIFont fontWithName:@"Zapfino" size:18];
    labelTitle.text = @"使用反馈";
    [imageViewBg addSubview:labelTitle];
    
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBack.frame = CGRectMake(10, 22, 40, 40);
    [buttonBack setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [buttonBack addTarget:self action:@selector(onActionBack) forControlEvents:UIControlEventTouchUpInside];
    [imageViewBg addSubview:buttonBack];
    
    self.viewFeedback = [[FeedbackView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_BAR_HEIGHT)];
    [self.view addSubview:self.viewFeedback];
    self.viewFeedback.blockSubmit = ^(NSString *strContent) {
      
        [weakSelf requestDataWithContent:strContent];
    };
}

- (void)requestDataWithContent:(NSString *)strContent
{
    [LCProgressHUD showSuccess:@"反馈成功"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onActionBack
{
    [self.navigationController popViewControllerAnimated:YES];
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
