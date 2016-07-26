//
//  GKBaseViewController.h
//  RecordForSaid
//
//  Created by 花菜ChrisCai on 2016/7/26.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKBaseViewController : UIViewController
/** 数据源 */
@property(nonatomic, strong) NSMutableArray *dataSource;
/** 表格控件 */
@property(nonatomic, strong) UITableView *tableView;
@end
