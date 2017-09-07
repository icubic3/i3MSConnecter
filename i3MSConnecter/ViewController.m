//
//  ViewController.m
//  i3MSConnecter
//
//  Created by i3 on 2017/8/11.
//  Copyright © 2017年 com.breo. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "MSFriendModel.h"
#import "Masonry.h"
#import "RegexKitLite.h"

@interface ViewController ()

@property (nonatomic, strong)UITextField * textField;
@property (nonatomic, strong)UITextField * nameTextField;
@property (nonatomic, strong)UIButton *addFriendBtn;
@property (nonatomic, strong)NSMutableArray *friendList;

@end

@implementation ViewController{
    NSUserDefaults *database;
    
}

- (UITextField *)nameTextField{
    if (!_nameTextField) {
        _nameTextField = [UITextField new];
        _nameTextField.borderStyle = UITextBorderStyleLine;
        [self.view addSubview:_nameTextField];
        _nameTextField.placeholder = @"请输入好友名字(可随便输入)";
    }
    return _nameTextField;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [UITextField new];
        _textField.borderStyle = UITextBorderStyleLine;
        [self.view addSubview:_textField];
        _textField.placeholder = @"请输入邀请信息";
//        _textField.text = @"好友大征集！让我们并肩作战，齐心协力突破难关！「追求光之进化(上级)」http://static.monster-strike.com.cn/sns/?pass_code=MzAyNzc3NjIxMzk5&f=wechat↑点击这个链接，立刻加入多人联机战队吧！https://www.monster-strike.com.cn/↑还没玩过怪物弹珠？点击链接，通过官网下载游戏吧！";
    }
    return _textField;
}

- (NSMutableArray *)friendList{
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:[database objectForKey:@"friendList"]];
    _friendList = [arr mutableCopy];
    if (!_friendList) {
        _friendList = [NSMutableArray array];
    }
    return _friendList;

    
}

- (UIButton *)addFriendBtn{
    if (!_addFriendBtn) {
        _addFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addFriendBtn setTitle:@"添加好友" forState:UIControlStateNormal];
        [_addFriendBtn setBackgroundColor:[UIColor grayColor]];
        _addFriendBtn.layer.cornerRadius = 10;
        [self.view addSubview:_addFriendBtn];
    }
    [_addFriendBtn addTarget:self action:@selector(saveFriend) forControlEvents:UIControlEventTouchUpInside];
    return _addFriendBtn;
}

- (void)saveFriend{
    if (self.textField.text.length > 0) {
        MSFriendModel *friModel = [MSFriendModel new];
        friModel.name = self.nameTextField.text;
        friModel.passCode = [self getPassCode];
        BOOL isSave = YES;
        for (MSFriendModel *m in self.friendList) {
            if ([m.passCode isEqualToString:friModel.passCode]) {
                isSave = NO;
            }
        }
        if (isSave) {
            [_friendList addObject:friModel];
        }
        
        [database setObject:[NSKeyedArchiver archivedDataWithRootObject:_friendList] forKey:@"friendList"];
        [[[UIAlertView alloc]initWithTitle:@"保存成功" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
//        NSLog(@"dadada=====%@",[self getPassCode:self.textField.text]);
    }else{
        [[[UIAlertView alloc]initWithTitle:@"邀请信息不能为空" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    }
}

- (NSString *)getPassCode{

    NSString *re = @"pass_code=(.+)&";

    return [self.textField.text stringByMatching:re capture:1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initLayouts];
    self.title = @"添加好友";
    database = [NSUserDefaults standardUserDefaults];

}

- (void)initLayouts{
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view).multipliedBy(0.8);
        make.height.mas_equalTo(50);
    }];
    
    [self.addFriendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.textField);
        make.top.mas_equalTo(self.textField.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.textField);
    }];
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.textField);
        make.bottom.mas_equalTo(self.textField.mas_top);
        make.centerX.mas_equalTo(self.textField);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGFloat offset = self.view.frame.size.height - (textField.frame.origin.y+textField.frame.size.height+216+50);
    if (offset <= 0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = offset;
            self.view.frame = frame;
        }];
    }

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (self.view.frame.origin.y < 0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = 0;
            self.view.frame = frame;
            //
        }];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            [view resignFirstResponder];
        }
    }
}


@end
