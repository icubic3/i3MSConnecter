//
//  MSFriendController.m
//  i3MSConnecter
//
//  Created by i3 on 2017/8/11.
//  Copyright © 2017年 com.breo. All rights reserved.
//

#import "MSFriendController.h"
#import "MSFriendModel.h"
#import "Masonry.h"

@interface MSFriendController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UIButton *manageBtn;


@end

@implementation MSFriendController{
    NSUserDefaults *database;
}

- (UIButton *)manageBtn{
    if (!_manageBtn) {
        _manageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_manageBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_manageBtn addTarget:self action:@selector(switchEditMode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _manageBtn;
}

- (void)switchEditMode{
    NSString *title;
    if (self.tableView.editing) {
        title = @"编辑";
        [self.tableView setEditing:NO animated:YES];

    }else{
        title = @"完成";
        [self.tableView setEditing:YES animated:YES];
    }
    
    [self.manageBtn setTitle:title forState:UIControlStateNormal];

}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:[database objectForKey:@"friendList"]];
    _dataArray = [arr mutableCopy];
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友列表";
    database = [NSUserDefaults standardUserDefaults];
    [self initLayouts];
    // Do any additional setup after loading the view.
}

- (void)initLayouts{
    self.tableView.frame = self.view.bounds;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:self.manageBtn];
    [self.manageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(view).offset(-5);
        make.right.mas_equalTo(view).offset(-20);
    }];
    
    return view;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idenf = @"cell";
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenf];
    }
    MSFriendModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MSFriendModel *model = self.dataArray[indexPath.row];
    NSString *url = [NSString stringWithFormat:@"monsterstrike-cn-app://joingame/?join=%@&from=wechat",model.passCode];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataArray removeObjectAtIndex:indexPath.row];
        [database setObject:[NSKeyedArchiver archivedDataWithRootObject:_dataArray] forKey:@"friendList"];
    }
    [self.tableView reloadData];
}

@end
