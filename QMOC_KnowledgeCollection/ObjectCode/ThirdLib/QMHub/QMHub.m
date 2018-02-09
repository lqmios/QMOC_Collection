//
//  QMHub.m
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/10.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import "QMHub.h"
#import <UIKit/UIKit.h>
#import "Category_Header.h"

@implementation QMHub

+ (void)showToastWithTitle:(NSString *) titleStr imgString:(NSString *)imgString
{
    UIView *toastView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 173, 123)];
    
    UIView *bgView = [[UIView alloc] initWithFrame:toastView.bounds];
    [bgView setBackgroundColor:[UIColor colorWithHexString:@"#000000"]];
    [bgView setAlpha:0.8f];
    [toastView addSubview:bgView];
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(173/2 - 15, 20, 30, 30)];
    imageView.image = [UIImage imageNamed:imgString];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+ 5,  173, 40)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont systemFontOfSize:14]];
    [titleLabel setText:titleStr];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.numberOfLines = 2;
    
    [toastView addSubview:imageView];
    [toastView addSubview:titleLabel];
    [toastView setBackgroundColor:[UIColor clearColor]];
    [toastView.layer setMasksToBounds:YES];
    [toastView.layer setCornerRadius:5];
    //居中
    [toastView setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2)];
    
    [[UIApplication sharedApplication].keyWindow addSubview:toastView];
    
    [toastView setAlpha:0];
    
    [UIView animateWithDuration:0.35 animations:^{
        [toastView setAlpha:1];
    } completion:^(BOOL finished) {
        double delayInSeconds = 1.0;
        dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_queue_t concurrentQueue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.35 animations:^{
                    [toastView setAlpha:0];
                } completion:^(BOOL finished) {
                    [toastView removeFromSuperview];
                }];
            });
        });
    }];
}



@end





















