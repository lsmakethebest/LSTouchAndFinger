//
//  ViewController.m
//  指纹+3DTouch
//
//  Created by 刘松 on 16/8/18.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
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
- (void)authenticateUser
{
    //初始化上下文对象
    LAContext* context = [[LAContext alloc] init];
    //错误对象
    NSError* error = nil;
    NSString* result = @"Authentication is needed to access your notes.";
    
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            if (success) {
                //验证成功，主线程处理UI
                [self presentViewController: [UIAlertController alertControllerWithTitle:@"fsdf" message:@"fsdd" preferredStyle:(UIAlertControllerStyleAlert)]  animated:YES completion:nil];;
            }
            else
            {
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"Authentication was cancelled by the system");
                        //切换到其他APP，系统取消验证Touch ID
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        NSLog(@"Authentication was cancelled by the user");
                        //用户取消验证Touch ID
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        NSLog(@"User selected to enter custom password");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //用户选择其他验证方式，切换主线程处理
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //其他情况，切换主线程处理
                        }];
                        break;
                    }
                }
            }
        }];
    }
    else
    {
        //不支持指纹识别，LOG出错误详情
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                 //设备Touch ID不可用，用户未录入
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                 //系统未设置密码
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                   //设备Touch ID不可用，例如未打开
                NSLog(@"TouchID not available");
                break;
            }
        }
        
        NSLog(@"%@",error.localizedDescription);
//        [self showPasswordAlert];
    }
}
/*
typedef NS_ENUM(NSInteger, LAError)
{
    //授权失败
    LAErrorAuthenticationFailed = kLAErrorAuthenticationFailed,
    
    //用户取消Touch ID授权
    LAErrorUserCancel           = kLAErrorUserCancel,
    
    //用户选择输入密码
    LAErrorUserFallback         = kLAErrorUserFallback,
    
    //系统取消授权(例如其他APP切入)
    LAErrorSystemCancel         = kLAErrorSystemCancel,
    
    //系统未设置密码
    LAErrorPasscodeNotSet       = kLAErrorPasscodeNotSet,
    
    //设备Touch ID不可用，例如未打开
    LAErrorTouchIDNotAvailable  = kLAErrorTouchIDNotAvailable,
    
    //设备Touch ID不可用，用户未录入
    LAErrorTouchIDNotEnrolled   = kLAErrorTouchIDNotEnrolled,
} NS_ENUM_AVAILABLE(10_10, 8_0);
*/

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
