//
//  GKHomeViewController.m
//  RecordForSaid
//
//  Created by 花菜ChrisCai on 2016/7/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKHomeViewController.h"
#import "GKRecordModel.h"
#import "GKCommonCell.h"
#import "GKDetailViewController.h"
#import "GKNavigationController.h"
#import "GKBlockedBarButtonItem.h"
#import "GKSettingViewController.h"
@interface GKHomeViewController ()
/** 当前日期的所有的数据 */
@property(nonatomic, strong) NSArray *dataArray;
@end

@implementation GKHomeViewController
#pragma mark -
#pragma mark - =============== 生命周期方法 ===============

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 70;
    self.tableView.contentInsetTop = 10;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self setupNav];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString * timeStr = [[NSDate new]gk_yyyyMMddTimeString];
    // 获取今天的日记
    self.dataArray = [[GKDatabaseManager sharedManager] selectObject:[GKRecordModel class] propertyName:@"createTime" type:GKDatabaseSelectRangOfString content:timeStr];
    [self.tableView reloadData];
}

- (void)setupNav {
    GKWeakSelf(self)
    self.navigationItem.rightBarButtonItem = [GKBlockedBarButtonItem blockedBarButtonItemWithTitle:@"设置" eventHandler:^{
        [weakself.navigationController pushViewController:[[GKSettingViewController alloc] init] animated:YES];
    }];
}
#pragma mark -
#pragma mark - =============== UITableViewDatasource===============
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GKCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GKCommonCell"];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark - =============== UITableViewDelegate  ===============
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GKRecordModel * model = self.dataArray[indexPath.row];
    GKDetailViewController * detailVc = [[GKDetailViewController alloc]init];
    detailVc.model = model;
    [self.navigationController pushViewController:detailVc animated:YES];
}
@end
