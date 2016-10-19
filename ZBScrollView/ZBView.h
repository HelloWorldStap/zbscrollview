//
//  ZBView.h
//  ZBScrollView
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ScrollviewDerection)
{
    ScrollviewDerectiontop,
    ScrollviewDerectionDown
};

@class ZBView;
@protocol ZBViewDatasouce <NSObject>
@required
/**
 轮播图的个数
 */
-(NSInteger)zbviewnumberofViewCount;
/**
 view的样式此处只能是一样的样式
 */
-(UIView *)zbviewStyle;
/**
定时器每次都会调用该方法修改数据
 */
-(void)zbview:(UIView*)styleview ChangeDatasouceAtIndex:(NSInteger)index;

@end
@protocol zbviewdeleget <NSObject>

/**
 点击的哪一个数据
 */
-(void)zbview:(UIView *)styleview didselectedindex:(NSInteger)index;
@end


@interface ZBView : UIView
/**
 数据源方法
 */
@property(nonatomic,assign)id<ZBViewDatasouce>datasouce;
/**
 代理方法
 */
@property(nonatomic,assign)id<zbviewdeleget>deleget;
//停留时间
@property(nonatomic,assign)CGFloat stoptime;
//动画时间
@property(nonatomic,assign)CGFloat annmaintime;
/**
滑动的方向top向上down向下
 */
@property(nonatomic,assign)ScrollviewDerection dection;


/**
 刷新的方法
 */
-(void)zbreloddata;


@end
