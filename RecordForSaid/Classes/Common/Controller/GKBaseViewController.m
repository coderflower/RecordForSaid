//
//  GKBaseViewController.m
//  RecordForSaid
//
//  Created by 花菜ChrisCai on 2016/7/26.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKBaseViewController.h"
#import "GKRecordModel.h"
#import "GKCommonCell.h"
#import "GKDetailViewController.h"
#import "GKNavigationController.h"
@interface GKBaseViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation GKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[NSUserDefaults standardUserDefaults]boolForKey: kNightModelKey]) {
        self.tableView.backgroundColor = GKNightBackgroundColor;
    }else {
        self.tableView.backgroundColor = GKDaytimeBackgroundColor;
    }
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView =  [[UITableView alloc] init];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark -
#pragma mark - =============== UITableViewDatasource===============
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GKCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GKCommonCell"];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark - =============== UITableViewDelegate  ===============
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GKRecordModel * model = self.dataSource[indexPath.row];
    GKDetailViewController * detailVc = [[GKDetailViewController alloc]init];
    detailVc.model = model;
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    GKRecordModel * model = self.dataSource[indexPath.row];
    [self.dataSource removeObject:model];
    [[GKDatabaseManager sharedManager] deleteObject:model];
    [tableView reloadData];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource =  [[NSMutableArray alloc] init];
        
    }
    return _dataSource;
}
@end
