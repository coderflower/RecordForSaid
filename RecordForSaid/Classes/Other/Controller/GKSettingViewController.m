//
//  GKSettingViewController.m
//  RecordForSaid
//
//  Created by 花菜ChrisCai on 2016/7/28.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKSettingViewController.h"
#import "GKAboutViewController.h"

@interface GKSettingViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *pushNoteSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *nightModelSwitch;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;
@property (weak, nonatomic) IBOutlet UIView *aboutView;
@property (weak, nonatomic) IBOutlet UILabel *pushLabel;
@property (weak, nonatomic) IBOutlet UIView *pushView;
@property (weak, nonatomic) IBOutlet UIView *nightView;
@property (weak, nonatomic) IBOutlet UILabel *nightLabel;

@end

@implementation GKSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.pushNoteSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kPushNotelKey];
    self.nightModelSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kNightModelKey];
    [self setColor];
}

/// 夜间模式开关
- (IBAction)nightModel:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:kNightModelKey];
    [self setTheme];
    [self setColor];
}

- (void)setColor {
    if (self.nightModelSwitch.isOn) {
        self.view.backgroundColor = GKNightBackgroundColor;
        self.pushView.backgroundColor = GKRGBColor(150, 150, 150);
        self.nightView.backgroundColor = GKRGBColor(150, 150, 150);
        self.aboutView.backgroundColor = GKRGBColor(150, 150, 150);
        self.pushLabel.textColor = GKDaytimeBackgroundColor;
        self.nightLabel.textColor = GKDaytimeBackgroundColor;
        self.aboutLabel.textColor = GKDaytimeBackgroundColor;
    }else {
        self.view.backgroundColor = GKDaytimeBackgroundColor;
        self.pushView.backgroundColor = [UIColor whiteColor];
        self.nightView.backgroundColor = [UIColor whiteColor];
        self.aboutView.backgroundColor = [UIColor whiteColor];
        self.pushLabel.textColor = [UIColor blackColor];
        self.nightLabel.textColor = [UIColor blackColor];
        self.aboutLabel.textColor = [UIColor blackColor];
    }
}
/// 推送通知开关
- (IBAction)pushNote:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:kPushNotelKey];
}

- (IBAction)aboutButtonClick {
     [self.navigationController pushViewController:[[GKAboutViewController alloc] init]animated:YES];
}


- (void)setTheme {
    // 获取全局导航条
    UINavigationBar * navBar = [UINavigationBar appearance];
    NSMutableDictionary * attri = [NSMutableDictionary dictionary];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kNightModelKey]) {
        // 夜间模式
        [self.navigationController.navigationBar setBackgroundImage:[UIImage gk_imageWithColor:GKRGBColor(85, 85, 85)] forBarMetrics:UIBarMetricsDefault];
        [self.tabBarController.tabBar  setBackgroundImage:[UIImage gk_imageWithColor:GKRGBColor(85, 85, 85)]];
        attri[NSForegroundColorAttributeName] = [UIColor  whiteColor];
        [navBar setTintColor:[UIColor whiteColor]];
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    }else {
        // 白天模式
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
         [self.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"]];
        attri[NSForegroundColorAttributeName] = [UIColor  blackColor];
        [navBar setTintColor:GKRGBColor(85, 85, 85)];
        [self.navigationController.navigationBar setTintColor:GKRGBColor(85, 85, 85)];
    }
    [navBar setTitleTextAttributes:attri];
    [self.navigationController.navigationBar setTitleTextAttributes:attri];
}

@end
