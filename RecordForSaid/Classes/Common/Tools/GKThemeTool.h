//
//  GKThemeTool.h
//  换肤
//
//  Created by 花菜ChrisCai on 2016/6/30.
//  Copyright © 2016年 Chris.Cai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
UIKIT_EXTERN  NSString * const GKThemeKey;

UIKIT_EXTERN NSString * const kNightModelKey;
UIKIT_EXTERN NSString * const kPushNotelKey;
@interface GKThemeTool : NSObject

+ (void)setTheme;
@end
