//
//  GKDetailViewController.h
//  RecordForSaid
//
//  Created by 花菜ChrisCai on 2016/7/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GKRecordModel;
@interface GKDetailViewController : UIViewController
/** 模型数据 */
@property(nonatomic, strong) GKRecordModel *model;
@end
