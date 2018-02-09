//
//  MainViewController_1.m
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/2/9.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import "MainViewController_1.h"
#import "AlertOrPopViewController.h"
#import "QMShapeBezierViewController.h"
#import "QMThreadViewController.h"
#import "Macro_header.h"

@interface MainViewController_1 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView                 *tableView;

@end

@implementation MainViewController_1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
    
}
- (void)initSubViews{
    // 标题(不建议使用self.title属性)
    self.navigationItem.title = @"MMMMM";
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.frame = CGRectMake(0, Navgation_Height, self.view.bounds.size.width, self.view.bounds.size.height - 49);
}

#pragma mark --UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *identifier = @"_idenfier";
    /*不复用cell*/
    NSString *cellIdentifier = [NSString stringWithFormat:@"%zd_%zd",indexPath.row,indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"弹框";
            break;
        case 1:
            cell.textLabel.text = @"CAShapeLayer+ UIBezierPath";
            break;
            
        case 2:
            cell.textLabel.text = @"线程";
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0) {
        AlertOrPopViewController *alertPopView = [[AlertOrPopViewController alloc]init];
        [self.navigationController pushViewController:alertPopView animated:YES];
    }
    else if (indexPath.row == 1)
    {
        QMShapeBezierViewController *qmShapeVc = [[QMShapeBezierViewController alloc]init];
        [self.navigationController pushViewController:qmShapeVc animated:YES];
    }else{
        
        QMThreadViewController *threadVc = [[QMThreadViewController alloc]init];
        [self.navigationController pushViewController:threadVc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark --lazy ---
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
        _tableView.separatorColor = [UIColor colorWithWhite:0.9 alpha:1];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1];
        _tableView.estimatedRowHeight = 0;
    }
    return _tableView;
}


@end
