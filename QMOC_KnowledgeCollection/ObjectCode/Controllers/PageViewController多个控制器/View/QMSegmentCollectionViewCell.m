//
//  QMSegmentCollectionViewCell.m
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/8.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import "QMSegmentCollectionViewCell.h"

@implementation QMSegmentCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.textLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _textLabel.frame = self.bounds;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

@end
