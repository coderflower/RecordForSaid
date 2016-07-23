//
//  GKMeViewController.m
//  RecordForSaid
//
//  Created by 花菜ChrisCai on 2016/7/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKMeViewController.h"
#import "GKCommonCell.h"
#import "GKDetailViewController.h"
#include "GKRecordModel.h"
@interface GKMeViewController ()
/** 所有日记 */
@property(nonatomic, strong) NSArray *dataArray;
@end

@implementation GKMeViewController
#pragma mark -
#pragma mark - =============== 生命周期方法 ===============
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 70;
    self.tableView.contentInsetTop = 10;
    // 快速去除分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 获取今天的日记
    self.dataArray = [[GKDatabaseManager sharedManager] selecteDataWithClass:[GKRecordModel class]];
    [self.tableView reloadData];
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
