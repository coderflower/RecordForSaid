//
//  GKCommonCell.m
//  RecordForSaid
//
//  Created by 花菜ChrisCai on 2016/7/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKCommonCell.h"
@interface GKCommonCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/** 背景颜色数组 */
@property(nonatomic, strong) NSArray *colorArray;
@end
@implementation GKCommonCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
- (NSArray *)colorArray {
    if (!_colorArray) {
        _colorArray =  [[NSArray alloc] init];
        _colorArray = @[
                        GKRGBColor(1, 152, 117),
                        GKRGBColor(23, 137, 155),
                        GKRGBColor(250, 154, 79),
                        GKRGBColor(91, 114, 34),
                        GKRGBColor(233, 87, 95),
                        GKRGBColor(241, 167, 162),
                        GKRGBColor(89, 113, 173),
                        GKRGBColor(112, 219, 219),
                        GKRGBColor(133, 117, 112),
                        GKRGBColor(28, 152, 170)
                        ];
    }
    return _colorArray;
}
- (void)setFrame:(CGRect)frame {
    frame.origin.x = 10;
    frame.size.width -= 20;
    frame.size.height -= 10;
    [super setFrame:frame];
}

- (void)setModel:(GKRecordModel *)model {
    _model = model;
    self.timeLabel.text = model.createTime;
    self.titleLabel.text = model.title;
    self.contentView.backgroundColor = self.colorArray[arc4random_uniform(10)];
    self.titleLabel.backgroundColor = self.contentView.backgroundColor;
    self.timeLabel.backgroundColor = self.contentView.backgroundColor;
}
@end
