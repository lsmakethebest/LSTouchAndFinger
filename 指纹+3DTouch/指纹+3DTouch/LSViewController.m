

//
//  LSViewController.m
//  指纹+3DTouch
//
//  Created by 刘松 on 16/8/18.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSViewController.h"

@interface LSViewController ()

@end

@implementation LSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"我就是我" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"click---我就是我");
        
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"你还是你" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"click---你还是你");
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"她还是她" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"click---她还是她");
    }];
    //想要显示多个就定义多个 UIPreviewAction
    NSArray *actions = @[action1,action2,action3];
    return actions;
}


@end
