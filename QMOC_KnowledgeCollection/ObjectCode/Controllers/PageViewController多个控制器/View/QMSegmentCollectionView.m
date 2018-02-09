//
//  QMSegmentCollectionView.m
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/8.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import "QMSegmentCollectionView.h"
#import "QMSegmentCollectionViewCell.h"

//最大放大倍数
static const CGFloat ItemMaxScale = 1.10;

@interface QMSegmentCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView                     *collectionView;
/**底部跟随线*/
@property (nonatomic,strong) UIView                               *itemBottmLine;
@property (nonatomic,strong) UICollectionViewFlowLayout           *layout;
/**底部线条*/
@property (nonatomic,strong) UIView                                *bottomLineView;
@end

@implementation QMSegmentCollectionView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:[UIView new]];
        
        [self addSubview:self.collectionView];
        [self.collectionView addSubview:self.itemBottmLine];
        [self addSubview:self.bottomLineView];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.bounds.size.width - 30, self.bounds.size.height);
    self.bottomLineView.frame = CGRectMake(0, self.bounds.size.height - 1,  self.bounds.size.width , 1);
    
    /**如果标题过少，自动居中*/
    [self.collectionView performBatchUpdates:nil completion:^(BOOL finished) {
        if (self.collectionView.contentSize.width < self.collectionView.bounds.size.width) {
            CGFloat insetX = (self.collectionView.bounds.size.width - self.collectionView.contentSize.width) / 2.0f;
            self.collectionView.contentInset = UIEdgeInsetsMake(0, insetX, 0, insetX);
        }
    }];

    self.selectedIndex = _selectedIndex;
    self.itemBottmLine.backgroundColor = _itemSelectedColor;
    
}
#pragma mark -----setter------
- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    //更新底部跟随线frame（延迟是为了避免cell不在屏幕上显示时，造成的获取frame失败问题）
    CGFloat rectX = [self shadowRectOfIndex:_selectedIndex].origin.x;
    if (rectX <= 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.23 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            _itemBottmLine.frame = [self shadowRectOfIndex:self.selectedIndex];
        });
    }else{
        _itemBottmLine.frame = [self shadowRectOfIndex:self.selectedIndex];
    }
    //居中滚动标题
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    //更新字体
    [self.collectionView reloadData];
    //执行代理方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(qmSegmentCollectionViewDidSelectedAtIndex:)]) {
        [self.delegate qmSegmentCollectionViewDidSelectedAtIndex:self.selectedIndex];
    }
}

//更新阴影位置
- (void)setProgress:(CGFloat)progress {
    _progress = progress;

    //更新阴影位置
    [self updateShadowPosition:progress];
    //更新标题颜色、大小
    [self updateItem:progress];
}
#pragma mark 执行阴影过渡动画
#pragma mark ------------------更新底部跟随线位置------------------
- (void)updateShadowPosition:(CGFloat)progress {
    //progress > 1 向左滑动表格反之向右滑动表格
    NSInteger nextIndex = progress > 1 ? _selectedIndex + 1 : _selectedIndex - 1;
    if (nextIndex < 0 || nextIndex == _titles.count) {return;}
    //获取当前阴影位置
    CGRect currentRect = [self shadowRectOfIndex:_selectedIndex];
    CGRect nextRect = [self shadowRectOfIndex:nextIndex];
    //如果在此时cell不在屏幕上 则不显示动画
    if (CGRectGetMinX(currentRect) <= 0 || CGRectGetMinX(nextRect) <= 0) {return;}
    
    progress = progress > 1 ? progress - 1 : 1 - progress;
    
    //更新宽度
    CGFloat width = currentRect.size.width + progress*(nextRect.size.width - currentRect.size.width);
    CGRect bounds = _itemBottmLine.bounds;
    bounds.size.width = width;
    _itemBottmLine.bounds = bounds;
    
    //更新位置
    CGFloat distance = CGRectGetMidX(nextRect) - CGRectGetMidX(currentRect);
    _itemBottmLine.center = CGPointMake(CGRectGetMidX(currentRect) + progress* distance, _itemBottmLine.center.y);
}
//更新标题颜色
- (void)updateItem:(CGFloat)progress {
    
    NSInteger nextIndex = progress > 1 ? _selectedIndex + 1 : _selectedIndex - 1;
    //防止数组越界
    if (nextIndex < 0 || nextIndex == self.titles.count) {return;}
    
    QMSegmentCollectionViewCell *currentItem = (QMSegmentCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];
    
    QMSegmentCollectionViewCell *nextItem = (QMSegmentCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:nextIndex inSection:0]];
    progress = progress > 1 ? progress - 1 : 1 - progress;
    
    //更新颜色
    currentItem.textLabel.textColor = [self transformFromColor:_itemSelectedColor toColor:_itemNormalColor progress:progress];
    nextItem.textLabel.textColor = [self transformFromColor:_itemNormalColor toColor:_itemSelectedColor progress:progress];
    
    //更新放大
    CGFloat currentItemScale = ItemMaxScale - (ItemMaxScale - 1) * progress;
    CGFloat nextItemScale = 1 + (ItemMaxScale - 1) * progress;
    currentItem.transform = CGAffineTransformMakeScale(currentItemScale, currentItemScale);
    nextItem.transform = CGAffineTransformMakeScale(nextItemScale, nextItemScale);
}
#pragma mark CollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QMSegmentCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"QMSegmentCollectionViewCell" forIndexPath:indexPath];
    
    item.textLabel.text = self.titles[indexPath.row];
    item.textLabel.font = [UIFont systemFontOfSize:16];
    
    CGFloat scale = indexPath.row == _selectedIndex ? ItemMaxScale : 1;
    item.transform = CGAffineTransformMakeScale(scale, scale);
    
    item.textLabel.textColor = indexPath.row == _selectedIndex ? _itemSelectedColor : _itemNormalColor;
    
    return item;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake([self itemWidthOfIndexPath:indexPath], _collectionView.bounds.size.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
}

#pragma mark ---获取文字宽度
- (CGFloat)itemWidthOfIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = _titles[indexPath.row];
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByTruncatingTail];
    NSDictionary *attributes = @{ NSFontAttributeName : [UIFont boldSystemFontOfSize:16], NSParagraphStyleAttributeName : style };
    CGSize textSize = [title boundingRectWithSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height)
                                          options:opts
                                       attributes:attributes
                                          context:nil].size;
    return textSize.width;
}

- (CGRect)shadowRectOfIndex:(NSInteger)index{
    return CGRectMake([self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]].frame.origin.x, self.bounds.size.height - 2, [self itemWidthOfIndexPath:[NSIndexPath indexPathForRow:index inSection:0]], 2);
}

#pragma mark 功能性方法
- (UIColor *)transformFromColor:(UIColor*)fromColor toColor:(UIColor *)toColor progress:(CGFloat)progress {
    
    if (!fromColor || !toColor) {
        NSLog(@"Warning !!! color is nil");
        return [UIColor blackColor];
    }
    
    progress = progress >= 1 ? 1 : progress;
    
    progress = progress <= 0 ? 0 : progress;
    
    const CGFloat * fromeComponents = CGColorGetComponents(fromColor.CGColor);
    
    const CGFloat * toComponents = CGColorGetComponents(toColor.CGColor);
    
    size_t  fromColorNumber = CGColorGetNumberOfComponents(fromColor.CGColor);
    size_t  toColorNumber = CGColorGetNumberOfComponents(toColor.CGColor);
    
    if (fromColorNumber == 2) {
        CGFloat white = fromeComponents[0];
        fromColor = [UIColor colorWithRed:white green:white blue:white alpha:1];
        fromeComponents = CGColorGetComponents(fromColor.CGColor);
    }
    
    if (toColorNumber == 2) {
        CGFloat white = toComponents[0];
        toColor = [UIColor colorWithRed:white green:white blue:white alpha:1];
        toComponents = CGColorGetComponents(toColor.CGColor);
    }
    
    CGFloat red = fromeComponents[0]*(1 - progress) + toComponents[0]*progress;
    CGFloat green = fromeComponents[1]*(1 - progress) + toComponents[1]*progress;
    CGFloat blue = fromeComponents[2]*(1 - progress) + toComponents[2]*progress;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}
#pragma mark -----lazy-------

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[QMSegmentCollectionViewCell class] forCellWithReuseIdentifier:@"QMSegmentCollectionViewCell"];
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.minimumLineSpacing = 20;
        _layout.minimumInteritemSpacing = 25;
        _layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
    }
    return _layout;
}

- (UIView *)itemBottmLine
{
    if (!_itemBottmLine) {
        _itemBottmLine = [[UIView alloc] init];
    }
    return _itemBottmLine;
}

- (UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc]init];
        _bottomLineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _bottomLineView;
}

@end



































