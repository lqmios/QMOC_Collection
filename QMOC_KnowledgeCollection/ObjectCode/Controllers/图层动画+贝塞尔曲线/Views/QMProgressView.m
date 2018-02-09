//
//  QMProgressView.m
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/8.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import "QMProgressView.h"

@interface QMProgressView ()

@property (nonatomic,strong) UIView             *progressView;

@end

@implementation QMProgressView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.layer.cornerRadius = self.bounds.size.height / 2;
        self.layer.masksToBounds = YES;
        [self addSubview:self.progressView];
    }
    return self;
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    self.progressView.frame = CGRectMake(0, 0, self.bounds.size.width * progress, self.bounds.size.height);
}

- (UIView *)progressView{
    if (!_progressView) {
        _progressView = [[UIView alloc]init];
        _progressView.backgroundColor = [UIColor redColor];
        _progressView.layer.cornerRadius = self.bounds.size.height / 2;
        _progressView.layer.masksToBounds = YES;
    }
    return _progressView;
}


@end
