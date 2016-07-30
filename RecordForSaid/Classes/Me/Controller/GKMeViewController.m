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
#import "GKBlockedBarButtonItem.h"
#import "GKSettingViewController.h"
@interface GKMeViewController ()
@end

@implementation GKMeViewController
#pragma mark -
#pragma mark - =============== 生命周期方法 ===============
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
    [self setupNav];
}

- (void)setupTableView {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GKCommonCell class]) bundle:nil]forCellReuseIdentifier:@"GKCommonCell"];
    self.tableView.rowHeight = 70;
    self.tableView.contentInsetTop = 5;
    self.tableView.contentInsetBottom = 5;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [GKThemeTool setTheme];
    [MobClick beginLogPageView:@"Me"];
    // 获取今天的日记 , 并倒序排序
    self.dataSource = [[[GKDatabaseManager sharedManager] selecteDataWithClass:[GKRecordModel class]] reverseObjectEnumerator].allObjects.mutableCopy;
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"Me"];
}
- (void)setupNav {
    GKWeakSelf(self)
    
    self.navigationItem.rightBarButtonItem = [GKBlockedBarButtonItem blockedBarButtonItemWithTitle:@"设置" eventHandler:^{
        [weakself.navigationController pushViewController:[[GKSettingViewController alloc] init] animated:YES];
        
    }];
}
@end
