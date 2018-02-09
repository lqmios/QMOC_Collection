//
//  AlertOrPopViewController.m
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/4.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import "AlertOrPopViewController.h"
#import "Macro_header.h"
#import "QMHub.h"

@interface AlertOrPopViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView                 *tableView;

@end

@implementation AlertOrPopViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
    
}
- (void)initSubViews{
    // 标题(不建议使用self.title属性)
    self.navigationItem.title = @"弹框";
    [self.view addSubview:self.tableView];

}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, Navgation_Height, self.view.bounds.size.width, self.view.bounds.size.height - Navgationbar_Height - 44);

    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } 
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
            cell.textLabel.text = @"alter弹框";
            break;
            case 1:
            cell.textLabel.text = @"自定义HUB";
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0) {
        [self sheetAlert];
      
    }
    else if (indexPath.row == 1)
    {
        [QMHub showToastWithTitle:@"测试Toast" imgString:@"tab3_p"];
    }
    else{
        
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


- (void)sheetAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"400-6630-666" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"执行事件");

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://17620730522"]];

    }];
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"Destructive" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"执行事件2");
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    //颜色设置
    [cancelAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
    [alertController addAction:defaultAction];
    [alertController addAction:destructiveAction];
    [alertController addAction:cancelAction];

    [self presentViewController:alertController animated:YES completion:nil];
    
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

    }
    return _tableView;
}

@end
