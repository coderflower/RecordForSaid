//
//  GKPlaceholderTextView.h
//  Baisi
//
//  Created by 花菜ChrisCai on 2016/6/14.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKPlaceholderTextView : UITextView
/** 占位文字 */
@property(nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property(nonatomic, strong) UIColor *placeholderColor;
+ (instancetype)textView;
@end
