//
//  GKMeViewController.m
//  RecordForSaid
//
//  Created by 花菜ChrisCai on 2016/7/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKMeViewController.h"
#import "GKCommonCell.h"
#include "GKRecordModel.h"
@interface GKMeViewController ()
@end

@implementation GKMeViewController
#pragma mark -
#pragma mark - =============== 生命周期方法 ===============
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GKCommonCell class]) bundle:nil]forCellReuseIdentifier:@"GKCommonCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 获取今天的日记 , 并倒序排序
    self.dataSource = [[[GKDatabaseManager sharedManager] selecteDataWithClass:[GKRecordModel class]] reverseObjectEnumerator].allObjects.mutableCopy;
    [self.tableView reloadData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.rowHeight = 70;
    self.tableView.contentInsetTop = 5 + 64;
}
@end
