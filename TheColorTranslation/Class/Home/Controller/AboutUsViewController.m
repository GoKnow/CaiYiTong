//
//  AboutUsViewController.m
//  TheColorFor
//
//  Created by Rain on 2017/12/16.
//  Copyright © 2017年 Rain. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self constructUI];
}

- (void)constructUI
{
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
    labelTitle.text = @"关于";
    [imageViewBg addSubview:labelTitle];
    
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBack.frame = CGRectMake(10, 22, 40, 40);
    [buttonBack setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [buttonBack addTarget:self action:@selector(onActionBack) forControlEvents:UIControlEventTouchUpInside];
    [imageViewBg addSubview:buttonBack];
    
    UIImageView *imageViewIcon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 40, 100, 80, 80)];
    imageViewIcon.image = [UIImage imageNamed:@"icon_logo"];
    imageViewIcon.layer.cornerRadius = 5.0;
    imageViewIcon.layer.masksToBounds = YES;
    [self.view addSubview:imageViewIcon];
    
    NSString *strVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    UILabel *labelVersion = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, SCREEN_WIDTH - 20, 30)];
    labelVersion.textColor = [UIColor grayColor];
    labelVersion.textAlignment = NSTextAlignmentCenter;
    labelVersion.text = [NSString stringWithFormat:@"V %@",strVersion];
    [self.view addSubview:labelVersion];
    
    UILabel *labeInt1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 240, SCREEN_WIDTH - 40, 100)];
    labeInt1.numberOfLines = 0;
    labeInt1.text = @"极简实用翻译软件，同时支持28国语言的相互翻译，简单实用，旅游出差必备";
    labeInt1.textColor = [UIColor grayColor];
    labeInt1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labeInt1];
    
    
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
