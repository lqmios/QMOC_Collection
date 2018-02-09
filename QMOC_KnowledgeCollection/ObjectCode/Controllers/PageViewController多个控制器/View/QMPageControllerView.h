//
//  QMPageControllerView.h
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/8.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QMSegmentDelegate <NSObject>
/**
 * 切换位置后的代理方法
 */
- (void)qmPageControllerViewSwitchDidselectAtIndex:(NSInteger)index;
@end

@interface QMPageControllerView : UIView
/**
 * 需要显示的视图
 */
@property (nonatomic, strong) NSArray                         *viewControllers;
/**
 * 标题
 */
@property (nonatomic, strong) NSArray                         *titles;
/**
 * 选中位置
 */
@property (nonatomic, assign) NSInteger                      selectedIndex;
/**
 * 按钮正常时的颜色
 */
@property (nonatomic, strong) UIColor                       *itemNormalColor;
/**
 * 按钮选中时的颜色
 */
@property (nonatomic, strong) UIColor                       *itemSelectedColor;
/**
 * 隐藏阴影
 */
@property (nonatomic, assign) BOOL                          hideShadow;
/**
 * 代理方法
 */
@property (nonatomic, weak) id <QMSegmentDelegate>           delegate;
//箭头button
@property (nonatomic,strong) UIButton                          *arrowsButton;

/**
 * 初始化方法
 */
-(instancetype)initWithFrame:(CGRect)frame Titles:(NSArray <NSString *>*)titles viewControllers:(NSArray <UIViewController *>*) viewControllers;
/**
 * 标题显示在ViewController中
 */
-(void)showInViewController:(UIViewController *)viewController;


@end











