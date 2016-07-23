//
//  NSDate+GKExtension.h
//  新浪微博
//
//  Created by 花菜ChrisCai on 2014/5/21.
//  Copyright © 2014年 张积辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (GKExtension)

/**
 *  时分秒
 */
- (NSString *)gk_HHmmss_timeString;
/**
 *  yyyy-MM-dd
 */
- (NSString *)gk_yyyyMMddTimeString;
/**
 *  返回 yyyy-MM-dd HH:mm
 */
- (NSString *)gk_yyyyMMddHHmmTimeString;

/**
 *  时间格式化
 */
- (NSString *)gk_timeStringWithFormat:(NSString *)format;

+ (NSString * )gk_HHmmss_timeStringWithDateString:(NSString *)dateString;

+ (NSDate *)gk_dateFromTimeString:(NSString *)timeString format:(NSString *)format;
/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)gk_deltaFrom:(NSDate *)from;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)gk_deltaWithNow;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;
@end
