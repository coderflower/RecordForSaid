//
//  NSDate+GKExtension.m
//  新浪微博
//
//  Created by 花菜ChrisCai on 2014/5/21.
//  Copyright © 2014年 张积辉. All rights reserved.
//

#import "NSDate+GKExtension.h"

@implementation NSDate (GKExtension)

- (NSString *)gk_HHmmss_timeString
{
   return [self gk_timeStringWithFormat:@"HH:mm:ss"]; 
}
- (NSString *)gk_yyyyMMddHHmmTimeString
{
    return [self gk_timeStringWithFormat:@"yyyy-MM-dd HH:mm"];
}
- (NSString *)gk_yyyyMMddTimeString
{
    return [self gk_timeStringWithFormat:@"yyyy-MM-dd"];
}

- (NSString *)gk_timeStringWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = format;
    
    return [dateFormatter stringFromDate:self];
}

+ (NSString * )gk_HHmmss_timeStringWithDateString:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateString];
    NSString *time = [date gk_HHmmss_timeString];
    
    return time;
}


+ (NSDate *)gk_dateFromTimeString:(NSString *)timeString format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = format;
    return [formatter dateFromString:timeString];
}
/**
 *  是否为今年
 */
- (BOOL)isThisYear
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}
/**
 *  是否为今天
 */
- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    return [nowString isEqualToString:selfString];
}

/**
 *  是否为昨天
 */
- (BOOL)isYesterday
{
    // 2014-12-31 23:59:59 -> 2014-12-31
    // 2015-01-01 00:00:01 -> 2015-01-01
    
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}

- (NSDateComponents *)gk_deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}
/**
 *
 *  比较from和self的时间差值
 */
- (NSDateComponents *)gk_deltaFrom:(NSDate *)from
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:from toDate:self options:0];
}
@end
