//
//  QMShapeBezierViewController.m
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/8.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import "QMShapeBezierViewController.h"
#import "QMProgressView.h"
#import "Macro_header.h"

@interface QMShapeBezierViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView              *tableView;
/**进度条*/
@property (nonatomic,strong) QMProgressView           *qmProgressView;



@end

@implementation QMShapeBezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
}
- (void)initSubViews{

    self.navigationItem.title = @"图层动画+贝塞尔";
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.frame = CGRectMake(0, Navgation_Height, self.view.bounds.size.width, self.view.bounds.size.height - Navgationbar_Height - 44);
    
}
#pragma mark ----UITableViewDelegate,UITableViewDataSource----

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = [NSString stringWithFormat:@"rowid%zd-section%zd",indexPath.row,indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"进度条";
            self.qmProgressView.progress = 0.8;
            [cell.contentView addSubview:self.qmProgressView];
            break;
            
        default:
            break;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0) {
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark ---lazy

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        _tableView.separatorColor = [UIColor colorWithWhite:0.9 alpha:1];
        _tableView.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (QMProgressView *)qmProgressView{
    if (!_qmProgressView) {
        _qmProgressView = [[QMProgressView alloc]initWithFrame:CGRectMake(80, 100, self.view.bounds.size.width - 100, 20)];
    }
    return _qmProgressView;
}

@end












































