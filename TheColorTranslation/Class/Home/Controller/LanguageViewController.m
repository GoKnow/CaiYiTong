//
//  LanguageViewController.m
//  TheColorTranslation
//
//  Created by Rain on 2017/12/19.
//  Copyright © 2017年 Rain. All rights reserved.
//

#import "LanguageViewController.h"

@interface LanguageViewController () <UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *arrDataName;
@property (nonatomic ,strong) NSMutableArray *arrDataShorthand;

@end

@implementation LanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self constructData];
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
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 100, 30, 200, 34)];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.font = [UIFont systemFontOfSize:18];
    labelTitle.text = @"语言选择";
    [imageViewBg addSubview:labelTitle];
    
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBack.frame = CGRectMake(10, 22, 40, 40);
    [buttonBack setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [buttonBack addTarget:self action:@selector(onActionBack) forControlEvents:UIControlEventTouchUpInside];
    [imageViewBg addSubview:buttonBack];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, NAV_BAR_HEIGHT + 10, SCREEN_WIDTH - 40, SCREEN_HEIGHT - NAV_BAR_HEIGHT - 20) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.layer.cornerRadius = 3.0;
    self.tableView.layer.masksToBounds = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void)onActionBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrDataName.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.text = self.arrDataName[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.blockComplect) {

        self.blockComplect(self.arrDataName[indexPath.row], self.arrDataShorthand[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)constructData
{
    self.arrDataName = [[NSMutableArray alloc] initWithObjects:
                        @"自动检测",
                        @"中文",
                        @"英语",
                        @"粤语",
                        @"文言文",
                        @"日语",
                        @"韩语",
                        @"法语",
                        @"西班牙语",
                        @"泰语",
                        @"阿拉伯语",
                        @"俄语",
                        @"葡萄牙语",
                        @"德语",
                        @"意大利语",
                        @"希腊语",
                        @"荷兰语",
                        @"波兰语",
                        @"保加利亚语",
                        @"爱沙尼亚语",
                        @"丹麦语",
                        @"芬兰语",
                        @"捷克语",
                        @"罗马尼亚语",
                        @"斯洛文尼亚语",
                        @"瑞典语",
                        @"匈牙利语",
                        @"繁体中文",
                        @"越南语",nil];
    self.arrDataShorthand = [[NSMutableArray alloc] initWithObjects:
                        @"auto",
                        @"zh",
                        @"en",
                        @"yue",
                        @"wyw",
                        @"jp",
                        @"kor",
                        @"fra",
                        @"spa",
                        @"th",
                        @"ara",
                        @"ru",
                        @"pt",
                        @"de",
                        @"it",
                        @"el",
                        @"nl",
                        @"pl",
                        @"bul",
                        @"est",
                        @"dan",
                        @"fin",
                        @"cs",
                        @"rom",
                        @"slo",
                        @"swe",
                        @"hu",
                        @"cht",
                        @"vie",nil];
    if (!self.bHaveAuto) {
        
        [self.arrDataName removeObjectAtIndex:0];
        [self.arrDataShorthand removeObjectAtIndex:0];
    }

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
