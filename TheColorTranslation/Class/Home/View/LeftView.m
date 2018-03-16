//
//  LeftView.m
//  TheColorFor
//
//  Created by Rain on 2017/12/16.
//  Copyright © 2017年 Rain. All rights reserved.
//

#import "LeftView.h"

@interface LeftView () <UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong) UIImageView *imageViewHeader;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *arrData;
@end

@implementation LeftView

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
    
    self.backgroundColor = STCOLORA(42, 191, 134, 1.0);
    
    self.imageViewHeader = [[UIImageView alloc] initWithFrame:CGRectMake(75, 30, 40, 40)];
    [self addSubview:self.imageViewHeader];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, 200, SCREEN_HEIGHT - 70) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    [self addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.arrData = [[NSMutableArray alloc] initWithObjects:@"使用反馈",@"关于", nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = self.arrData[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.blockSelectRow) {
        
        self.blockSelectRow(indexPath.row);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
