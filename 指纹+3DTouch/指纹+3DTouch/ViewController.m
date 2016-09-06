//
//  ViewController.m
//  指纹+3DTouch
//
//  Created by 刘松 on 16/8/18.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "ViewController.h"

#import "LSViewController.h"
@interface ViewController ()<UIViewControllerPreviewingDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self authenticateUser];
    
    //注册3D Touch,先判断是否可用
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable){
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
        NSLog(@"3D Touch  可用!");
    }else{
        NSLog(@"3D Touch 无效");
    }
    
}
-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    
//    // 获取用户手势点所在cell的下标。同时判断手势点是否超出tableView响应范围。

    //坐标点的转化，
    CGFloat KMessageRowHeight=44;
    CGPoint tableLocation = [self.view convertPoint:location toView:self.tableView];
    NSIndexPath * selectedPath = [self.tableView indexPathForRowAtPoint:tableLocation];
    CGRect  sourceRect = CGRectMake(0, selectedPath.row * KMessageRowHeight, 375, KMessageRowHeight);
    // 如果row越界了，返回NO 不处理peek手势
    NSLog(@"当前所在的行---%@",selectedPath);
    if (selectedPath==nil) {
        return nil;
    }
    if (selectedPath.row>9) {
        return nil;
    }
//    //弹出视图的初始位置，sourceRect是peek触发时的高亮区域。这个区域内的View会高亮显示，其余的会模糊掉
    previewingContext.sourceRect = sourceRect;
    //获取数据进行传值
    UIViewController *vc=[[LSViewController alloc]init];
    vc.view.backgroundColor=[UIColor colorWithRed:0.593 green:0.710 blue:1.000 alpha:1.000];
    return vc;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}
@end
