//
//  GKDetailViewController.m
//  RecordForSaid
//
//  Created by 花菜ChrisCai on 2016/7/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKDetailViewController.h"
#import "GKRecordModel.h"
@interface GKDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentView;
@end

@implementation GKDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = self.model.title;
    self.contentView.text = self.model.record;
}
@end
