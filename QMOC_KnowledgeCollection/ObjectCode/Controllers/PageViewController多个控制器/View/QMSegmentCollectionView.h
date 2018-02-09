//
//  QMSegmentCollectionView.h
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/8.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QMSlideSegmentDelegate <NSObject>
- (void)qmSegmentCollectionViewDidSelectedAtIndex:(NSInteger)index;
@end

@interface QMSegmentCollectionView : UIView
@property (nonatomic, assign) NSInteger                                 selectedIndex;

@property (nonatomic, strong) NSArray                                   *titles;

@property (nonatomic, strong) UIColor                                   *itemNormalColor;

@property (nonatomic, strong) UIColor                                   *itemSelectedColor;

@property (nonatomic, assign) BOOL                                       showTitlesInNavBar;

@property (nonatomic, assign) BOOL                                       hideShadow;

@property (nonatomic, weak) id<QMSlideSegmentDelegate>                  delegate;

@property (nonatomic, assign) CGFloat                                   progress;

@end
















