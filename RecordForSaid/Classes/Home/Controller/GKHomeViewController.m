//
//  GKHomeViewController.m
//  RecordForSaid
//
//  Created by 花菜ChrisCai on 2016/7/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKHomeViewController.h"
#import "GKCommonCell.h"
#import "GKRecordModel.h"
#import "GKBlockedBarButtonItem.h"
#import "GKSettingViewController.h"

#import <Savanna/Savanna.h>
#import <SFFoundation/SFFoundation.h>
#import <SFiOSKit/SFiOSKit.h>

@interface GKHomeViewController ()

@property (nonatomic, strong) SVApp *pluginApp;

@end

@implementation GKHomeViewController
#pragma mark -
#pragma mark - =============== 生命周期方法 ===============

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GKCommonCell class]) bundle:nil]forCellReuseIdentifier:@"GKCommonCell"];
    [self setupNav];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString * timeStr = [[NSDate new]gk_yyyyMMddTimeString];
    // 获取今天的日记 ,并倒序排序
    self.dataSource = [[[GKDatabaseManager sharedManager] selectObject:[GKRecordModel class] propertyName:@"createTime" type:GKDatabaseSelectRangOfString content:timeStr] reverseObjectEnumerator].allObjects.mutableCopy;
    [self.tableView reloadData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.rowHeight = 70;
    self.tableView.contentInsetTop = 5 + 64;
}
- (void)setupNav {
    GKWeakSelf(self)
    self.navigationItem.rightBarButtonItem = [GKBlockedBarButtonItem blockedBarButtonItemWithTitle:@"设置" eventHandler:^{
        [weakself.navigationController pushViewController:[[GKSettingViewController alloc] init] animated:YES];
    }];
    self.navigationItem.leftBarButtonItem = [GKBlockedBarButtonItem blockedBarButtonItemWithTitle:@"🚀" eventHandler:^{
        __strong typeof(weakself) self = weakself;
        
        [self sf_setLoading:YES];
        id<SVScriptBundle> bundle = [[SVOnlineAppBundle alloc] initWithURL:[NSURL URLWithString:@"http://1.myvoa.applinzi.com/com.yzx.imyvoa.plugins.pkg"]];
        if (!bundle) {
            bundle = [[SVScriptBundleRepository defaultRespository] scriptBundleWithBundleId:@"com.yzx.imyvoa.plugins"];
        } else {
            [[SVScriptBundleRepository defaultRespository] repositScriptBundle:bundle newBundleId:@"com.yzx.imyvoa.plugins"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bundle) {
                SVApp *app = [[SVApp alloc] initWithScriptBundle:bundle relatedViewController:self];
                
                self.pluginApp = app;
                [SVAppManager runApp:app];
                
                [self sf_setLoading:NO];
            } else {
                [UIAlertView sf_alertWithTitle:@"温馨提示" message:@"加载出错了，请稍后再试" completion:nil];
                [self sf_setLoading:NO];
            }
        });
    }];
}
@end
