//
//  GKPlaceholderTextView.m
//  Baisi
//
//  Created by 花菜ChrisCai on 2016/6/14.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "GKPlaceholderTextView.h"

@interface GKPlaceholderTextView ()
/** 占位文字label */
@property(nonatomic, weak) UILabel *placeholderLabel;
@end
@implementation GKPlaceholderTextView
#pragma mark -
#pragma mark - 初始化
+ (instancetype)textView
{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}


- (void)setup
{
    // 垂直方向永远有弹簧效果
    self.alwaysBounceVertical = YES;
    self.font = [UIFont systemFontOfSize:15];
    self.placeholderColor = [UIColor grayColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
}

- (void)textDidChange
{
    self.placeholderLabel.hidden = self.hasText;
}


#pragma mark -
#pragma mark - 懒加载
- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        UILabel *placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}

#pragma mark - 重写setter
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self textDidChange];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
    // 更新placeholderLabel的尺寸
    [self setNeedsLayout];
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = placeholder;
    // 更新placeholderLabel的尺寸
    // 在恰到的时候回调用layoutSubviews
    [self setNeedsLayout];
}

#pragma mark -
#pragma mark - 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat placeholderLabelX = 4;
    CGFloat placeholderLabelY = 7;
    CGFloat placeholderLabelWidth = self.bounds.size.width - 2 * placeholderLabelX;
    CGFloat placeholderLabelHeight = [self.placeholder boundingRectWithSize:CGSizeMake(placeholderLabelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size.height;
    self.placeholderLabel.frame = CGRectMake(placeholderLabelX, placeholderLabelY, placeholderLabelWidth, placeholderLabelHeight);
}

@end
