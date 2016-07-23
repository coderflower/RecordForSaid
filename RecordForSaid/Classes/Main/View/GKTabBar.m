//
//  GKTabBar.m
//  RecordForSaid
//
//  Created by 花菜ChrisCai on 2016/7/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKTabBar.h"
@interface GKTabBar ()
/// 发送按钮
@property(nonatomic, strong) UIButton *publishButton;
@end
@implementation GKTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 2.设置整体渲染颜色
        [self setTintColor:[UIColor colorWithRed:231/255.0 green:129/255.0 blue:112/255.0 alpha:1]];
        [self addSubview:self.publishButton];
    }
    return self;
}
/// 发送按钮
- (UIButton *)publishButton {
    if (!_publishButton) {
        _publishButton =  [[UIButton alloc] init];
        // 设置按钮图片
        [_publishButton setImage:[UIImage imageNamed:@"icon_3d_touch_write_24x24_"] forState:UIControlStateNormal];
        
        // 设置按钮背景图片
        [_publishButton setBackgroundImage:[UIImage imageNamed:@"button_tabbar_white_base_active_42x30_"] forState:UIControlStateNormal];
        
        // 设置尺寸
        _publishButton.size = _publishButton.currentBackgroundImage.size;
        // 按下
        [_publishButton addTarget:self action:@selector(publishButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishButton;
}

- (void)publishButtonClick {
    
    if (self.publishClick) {
        self.publishClick();
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 居中显示
    self.publishButton.center = CGPointMake(self.width / 2, self.height / 2);
    
    CGFloat itemX = 0;
    CGFloat itemY = 0;
    CGFloat itemW = self.width / 3;
    CGFloat itemH = self.height;
    
    // 遍历索引
    NSInteger index = 0;
    for (UIView *item in self.subviews) {
        if (![item isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        itemX = index > 0 ? (index + 1) * itemW : index * itemW;
        item.frame = CGRectMake(itemX, itemY, itemW, itemH);
        index++;
    }
}

@end
