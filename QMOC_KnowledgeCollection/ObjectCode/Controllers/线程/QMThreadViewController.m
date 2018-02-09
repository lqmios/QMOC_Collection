//
//  QMThreadViewController.m
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/11.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import "QMThreadViewController.h"
#import "Macro_header.h"
#import "QMNSTheadViewController.h"
#import "QMGCDViewController.h"
#import "QMNSOperationViewController.h"


@interface QMThreadViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView                 *tableView;


@end

@implementation QMThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initSubViews];
    
}

- (void)initSubViews{
    self.navigationItem.title = @"线程";
     [self.view addSubview:self.tableView];
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.frame = CGRectMake(0, Navgation_Height, self.view.bounds.size.width, self.view.bounds.size.height - 49);
}

#pragma mark --UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
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
            cell.textLabel.text = @"NSThead";
            break;
        case 1:
            cell.textLabel.text = @"GCD";
            break;
            
        case 2:
            cell.textLabel.text = @"NSOperation";
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0) {
      
        QMNSTheadViewController *thread = [[QMNSTheadViewController alloc]init];
        [self.navigationController pushViewController:thread animated:YES];
        
    }
    else if (indexPath.row == 1)
    {
        QMGCDViewController *gcd = [[QMGCDViewController alloc]init];
        [self.navigationController pushViewController:gcd animated:YES];
       
    }else{
   
        QMNSOperationViewController *operation = [[QMNSOperationViewController alloc]init];
        [self.navigationController pushViewController:operation animated:YES];
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



































