//
//  ZBView.m
//  ZBScrollView
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZBView.h"

@interface ZBView()
@property(nonatomic,strong)UIScrollView *zbscrollview;
@property(nonatomic,assign)NSInteger zbinter;
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,assign)NSInteger timerInter;

@property(nonatomic,assign)NSInteger realInter;

@property(nonatomic,strong)UIView *linview;

@property(nonatomic,strong)NSTimer *timer;


@end

@implementation ZBView
-(NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        [self initsouce];
    }
    return self;
}
-(void)addUI
{
    self.zbscrollview = [[UIScrollView alloc]init];
    [self addSubview:self.zbscrollview];
}
-(void)setDatasouce:(id<ZBViewDatasouce>)datasouce
{
    _datasouce = datasouce;
    [self addadtasouceUI];

}
-(void)setStoptime:(CGFloat)stoptime
{
    _stoptime=stoptime;
    [self.timer setFireDate:[NSDate distantPast]];
}
-(void)setAnnmaintime:(CGFloat)annmaintime
{
    _annmaintime = annmaintime;
    [self.timer setFireDate:[NSDate distantPast]];
}
-(void)setDection:(ScrollviewDerection)dection
{
    _dection = dection;
    
   //

    [self addadtasouceUI];
}
-(void)addadtasouceUI
{
    [self.array makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.array removeAllObjects];
    NSInteger zbcount = [self.datasouce zbviewnumberofViewCount];
    
    self.realInter = zbcount;
    self.zbinter = zbcount<2?zbcount:2;
    for (NSInteger i=0; i<self.zbinter; i++) {
        UIView *zbview = [self.datasouce zbviewStyle];
        [self.zbscrollview addSubview:zbview];
        [self.array addObject:zbview];
    }
    [self.zbscrollview setContentOffset:_dection==ScrollviewDerectiontop?CGPointMake(0, 0):CGPointMake(0,self.frame.size.height ) animated:NO];
    self.zbscrollview.contentSize = CGSizeMake(CGRectGetMaxX(self.frame), self.frame.size.height*self.zbinter);
    self.zbinter==0?:self.zbinter==1?[self onelable]:[self addTimer];

}
-(void)onelable
{
    [self.datasouce zbview:self.array[0] ChangeDatasouceAtIndex:0];

}
-(void)zbreloddata
{
    [self addadtasouceUI];
    [self setNeedsLayout];
}
-(void)initsouce
{

    self.timerInter = 0;
    _stoptime = 1;
    _annmaintime = 0.5;
    _dection = ScrollviewDerectiontop;

}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.zbscrollview.frame = self.bounds;
    
    for (NSInteger i=0; i<self.zbinter; i++) {
        UIView *zbview = self.array[i];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didseclected)];
        zbview.userInteractionEnabled = YES;
        [zbview addGestureRecognizer:tap];
        
        zbview.frame = CGRectMake(0, self.frame.size.height*i, self.frame.size.width, self.frame.size.height);
    }

}
/**
 添加定时器
 */
-(void)addTimer
{

    self.timer = [NSTimer scheduledTimerWithTimeInterval:_stoptime+_annmaintime target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    //添加到runloop中
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
        [self changedatasouce];

}
-(void)nextPage
{
    
    if (self.timerInter<self.realInter-1) {
        [self animation];
    }else
    {
        [self animation2];

    }

}
//开始出现的时候显示
-(void)changedatasouce
{
    NSInteger i = _dection==ScrollviewDerectiontop?0:1;
    NSInteger j = _dection==ScrollviewDerectiontop?1:0;
    [self.datasouce zbview:self.array[i] ChangeDatasouceAtIndex:self.timerInter];
    [self.datasouce zbview:self.array[j] ChangeDatasouceAtIndex:self.timerInter+1];
    self.timerInter=self.timerInter+1;


}
//正常交替的处理方式
-(void)animation
{
    //能让人看到拉取的y值
        CGFloat scroviewlookY ;
        scroviewlookY = _dection==ScrollviewDerectiontop?self.frame.size.height:0;
    //不能让人看到的偷偷拉回的y
    CGFloat scroviewScreatY;
    scroviewScreatY = _dection==ScrollviewDerectiontop?0:self.frame.size.height;
    
        [UIView animateWithDuration:_annmaintime animations:^{
        self.zbscrollview.contentOffset = CGPointMake(0, scroviewlookY);
            
        } completion:^(BOOL finished) {
            self.zbscrollview.contentOffset = CGPointMake(0, scroviewScreatY);
            
            [self changedatasouce];
        }];
}
//处于最末端的时候的处理方式
-(void)animation2
{
    
    //能让人看到拉取的y值
    CGFloat scroviewlookY ;
    scroviewlookY = _dection==ScrollviewDerectiontop?self.frame.size.height:0;
    //不能让人看到的偷偷拉回的y
    CGFloat scroviewScreatY;
    scroviewScreatY = _dection==ScrollviewDerectiontop?0:self.frame.size.height;

    [UIView animateWithDuration:_annmaintime animations:^{
        self.zbscrollview.contentOffset = CGPointMake(0, scroviewlookY);
        ;
    } completion:^(BOOL finished) {
        
        self.zbscrollview.contentOffset = CGPointMake(0, scroviewScreatY);
        
        NSInteger i = _dection==ScrollviewDerectiontop?0:1;
        NSInteger j = _dection==ScrollviewDerectiontop?1:0;
        [self.datasouce zbview:self.array[i] ChangeDatasouceAtIndex:self.realInter-1];
        [self.datasouce zbview:self.array[j] ChangeDatasouceAtIndex:0];
        self.timerInter = 0;

    }];

}
//点击出发的时间
-(void)didseclected
{
    NSInteger index;
    
    if (self.timerInter==0) {
        index = self.realInter-1;
    }else
    {
        index = self.timerInter-1;
    }
    
    if ([self.deleget respondsToSelector:@selector(zbview:didselectedindex:)]) {
        
        [self.deleget zbview:self.array[0] didselectedindex:index];
    }
}
@end
