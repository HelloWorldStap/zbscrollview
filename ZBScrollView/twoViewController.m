//
//  twoViewController.m
//  ZBScrollView
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "twoViewController.h"

#import "ZBView.h"
@interface twoViewController ()<ZBViewDatasouce,zbviewdeleget>
@property(nonatomic,strong)ZBView *zbview;
@property(nonatomic,strong)NSArray *array;
@end

@implementation twoViewController
//-(NSArray *)array
//{
//    if (!_array) {
//        _array = @[@"0",@"1",@"2",@"3",@"4"];
//    }
//    return _array;
//    
//}
-(ZBView *)zbview
{
    if (!_zbview) {
        _zbview = [[ZBView alloc]initWithFrame:CGRectMake(100, 200, 200, 40)];
        _zbview.backgroundColor = [UIColor grayColor];
        _zbview.datasouce = self;
        _zbview.deleget = self;
        _zbview.stoptime = 1;
        _zbview.annmaintime = 0.5;
        _zbview.dection = ScrollviewDerectiontop;
    }
    return _zbview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.zbview];
    [self performSelector:@selector(ceshi) withObject:nil afterDelay:3];
    // Do any additional setup after loading the view.
}
-(NSInteger)zbviewnumberofViewCount
{
    NSLog(@"-=-=-=-=-=-==%ld",self.array.count);
    
    NSLog(@"%@",self.array);
    
    return self.array.count;
}
-(void)ceshi
{
    
    NSArray *array = @[@"0",@"1",@"2",@"3",@"4"];
    self.array = array;
    [self.zbview zbreloddata];

}

/**
 view的样式此处只能是一样的样式
 */
-(UIView *)zbviewStyle
{
    
    UILabel *lable = [[UILabel alloc]init];
    lable.textColor = [UIColor redColor];
    lable.textAlignment = NSTextAlignmentCenter;
    return lable;
}
/**
 定时器每次都会调用该方法修改数据
 */
-(void)zbview:(UIView*)styleview ChangeDatasouceAtIndex:(NSInteger)index
{
    
    UILabel *label = (UILabel *)styleview;
    label.text = self.array[index];
    
}
-(void)zbview:(UIView *)styleview didselectedindex:(NSInteger)index
{
    NSLog(@"查看点击那一个%ld",(long)index);


}

-(void)tete
{
    NSLog(@"ceshi");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
