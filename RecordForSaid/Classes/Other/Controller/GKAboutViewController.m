//
//  GKAboutViewController.m
//  RecordForSaid
//
//  Created by 花菜ChrisCai on 2016/7/24.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKAboutViewController.h"

@interface GKAboutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *developerLabel;

@end

@implementation GKAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey: kNightModelKey]) {
        self.view.backgroundColor = GKNightBackgroundColor;
        self.developerLabel.textColor = GKDaytimeBackgroundColor;
        self.contentLabel.textColor = GKDaytimeBackgroundColor;
        self.titleLabel.textColor = GKDaytimeBackgroundColor;
    }else {
        self.view.backgroundColor = GKDaytimeBackgroundColor;
        self.developerLabel.textColor = GKNightBackgroundColor;
        self.contentLabel.textColor = GKNightBackgroundColor;
        self.titleLabel.textColor = GKNightBackgroundColor;
    }
}

@end
