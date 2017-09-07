//
//  MSHelpController.m
//  i3MSConnecter
//
//  Created by i3 on 2017/8/11.
//  Copyright © 2017年 com.breo. All rights reserved.
//

#import "MSHelpController.h"

@interface MSHelpController ()

@end

@implementation MSHelpController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITextView *textView = [UITextView new];
    textView.frame = self.view.bounds;
    [self.view addSubview:textView];
    textView.editable = NO;
    textView.font = [UIFont systemFontOfSize:20];
    
    textView.text = @"\n\n\n仅供怪物弹珠国服使用\n\n 1、如何加入房间：\n在添加好友界面，把好友发送到微信的邀请信息粘贴到【邀请信息】的框里，即可保存好友。下次好友开房后，可以直接通过点击好友列表中的对应好友，直接加入好友的房间（无需微信）。\n\n2、如何开房：\n在怪物弹珠国服中，选择【多人游戏】->【通过微信】，跳转到微信之后可以直接切换回游戏，拥有你的邀请信息的其他玩家可以通过此app直接加入房间。";
    
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

@end
