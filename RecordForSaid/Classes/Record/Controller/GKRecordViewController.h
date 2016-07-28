//
//  GKRecordViewController.h
//  RecordForSaid
//
//  Created by 花菜ChrisCai on 2016/7/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GKRecordViewController,GKRecordModel;
@protocol GKRecordViewControllerDelegate <NSObject>

@optional

- (void)recordViewController:(GKRecordViewController *)recordViewController completeEditingRecord:(GKRecordModel *)record;

@end

@interface GKRecordViewController : UIViewController
/** 代理 */
@property(nonatomic, weak) id<GKRecordViewControllerDelegate> delegate;
@end
