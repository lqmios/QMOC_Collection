//
//  QMDynamicAddCellController.m
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/11.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import "QMDynamicAddCellController.h"
#import "Macro_header.h"


@interface QMDynamicAddCellController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView                 *tableView;
@property (nonatomic,strong) NSMutableArray              *addDatas;
@property (nonatomic,strong) UIButton                    *addCellsButton;

@end

@implementation QMDynamicAddCellController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
    
}

- (void)initSubViews{
    self.navigationItem.title = @"动态添加cell";
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.frame = CGRectMake(0, Navgation_Height, self.view.bounds.size.width, self.view.bounds.size.height - 49);
    
    self.addCellsButton.frame = CGRectMake(20, 10, self.view.bounds.size.width - 40, 40);
    
}

- (void)addPeopleAction:(UIButton *)sender
{
    NSLog(@"添加人数");
    [self.addDatas addObject:@"1"];
    [self.tableView reloadData];
}

#pragma mark --UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger num;
    if (section == 0) {
        num = 3;
    }else{
        num = self.addDatas.count;
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *identifier = @"_idenfier";
    /*不复用cell*/
    if (indexPath.section == 0) {
        NSString *cellIdentifier = [NSString stringWithFormat:@"%zd_%zd",indexPath.row,indexPath.section];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"1";
                break;
            case 1:
                cell.textLabel.text = @"2";
                break;
                
            case 2:
                cell.textLabel.text = @"3";
                break;
            default:
                break;
        }
        return cell;
    }else {
        NSString *cellIdentifier = [NSString stringWithFormat:@"%zd_%zd",indexPath.row,indexPath.section];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
  
        
    }
    NSString *other = @"_other";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:other];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:other];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0) {
        
      
    }
    else if (indexPath.row == 1)
    {
     
        
    }else{
      
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
    if (section == 1) {
        static NSString *footer = @"footer";
        UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footer];
        if (!footerView) {
            footerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:footer];
            footerView.contentView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
        }
        [footerView.contentView addSubview:self.addCellsButton];
        return footerView;
    }
    static NSString *other = @"_other";
    UITableViewHeaderFooterView *otherView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:other];
    if (!otherView) {
        otherView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:other];
    }
    return otherView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    if (section == 1) {
        return 60;
    }
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
- (NSMutableArray *)addDatas{
    if (!_addDatas) {
        _addDatas = [NSMutableArray array];
    }
    return _addDatas;
}
- (UIButton *)addCellsButton{
    if (!_addCellsButton) {
        _addCellsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addCellsButton.backgroundColor = [UIColor redColor];
        [_addCellsButton setTitle:@"添加人数" forState:UIControlStateNormal];
        [_addCellsButton addTarget:self action:@selector(addPeopleAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _addCellsButton;
}

@end
