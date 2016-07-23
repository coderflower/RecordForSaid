//
//  GKRecordModel.h
//  RecordForSaid
//
//  Created by 花菜ChrisCai on 2016/7/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GKRecordModel : NSObject
/** 记录内容 */
@property(nonatomic, copy) NSString *record;
/** 时间 */
@property(nonatomic, copy) NSString *createTime;
/** 标题 */
@property(nonatomic, copy) NSString *title;
@end
