//
//  GKRecordViewController.m
//  RecordForSaid
//
//  Created by 花菜ChrisCai on 2016/7/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKRecordViewController.h"
#import "GKBlockedBarButtonItem.h"
#import "GKRecordModel.h"
#import "GKPlaceholderTextView.h"
#import <iflyMSC/iflyMSC.h>
@interface GKRecordViewController ()<IFlyRecognizerViewDelegate,UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *topBar;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;
/// 声明语音识别视图属性
@property (strong, nonatomic) IFlyRecognizerView *iflyRecognizerView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
/// 接收语音结果的数组
@property (strong, nonatomic) NSMutableString *resultString;
/// 用于显示记录内容
@property (strong, nonatomic)IBOutlet GKPlaceholderTextView *contentTextView;
/** 用于显示记录标题 */
@property(nonatomic, strong)IBOutlet UITextField *textField;
/** 开始录音按钮 */
@property(nonatomic, strong)IBOutlet UIButton *voiceButton;
/** 是否正在编辑标题 */
@property(nonatomic, assign) BOOL editingTitle;;
/** 工具条 */
@property(nonatomic, strong) UIToolbar *toolBar;
@end

@implementation GKRecordViewController
#pragma mark -
#pragma mark - =============== 声明周期方法 ===============
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.autoresizingMask = UIViewAutoresizingNone;
    // 创建表格
    [[GKDatabaseManager sharedManager] creatTableWithClassName:[GKRecordModel class]];
    self.view.backgroundColor = GKRGBColor(220, 220, 220);
    [self setupNav];
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"record"];
    self.editingTitle = YES;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kNightModelKey]) {
        self.topBar.backgroundColor = GKRGBColor(85, 85, 85);
        [self.completeButton setTitleColor:GKRGBColor(255, 255, 255) forState:UIControlStateNormal];
    }else {
        self.topBar.backgroundColor = GKRGBColor(247, 247, 247);
        [self.completeButton setTitleColor:GKRGBColor(85, 85, 85) forState:UIControlStateNormal];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.voiceButton.layer.cornerRadius = self.voiceButton.height * 0.5;
    self.voiceButton.layer.masksToBounds = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"record"];
}
/// 初始化子控件
- (void)setupSubviews {
   
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    self.textField.inputAccessoryView = self.toolBar;
    self.textField.delegate = self;
    self.textField.placeholder = @"在这里输入标题";
    
    self.contentTextView.font = [UIFont systemFontOfSize:15];
    self.contentTextView.placeholder = @"点击这里输入想要记录的事情";
    self.contentTextView.placeholderColor = [UIColor lightGrayColor];
    self.contentTextView.delegate = self;
    self.contentTextView.inputAccessoryView = self.toolBar;
    
    self.iflyRecognizerView = [[IFlyRecognizerView alloc] initWithCenter:CGPointMake(kScreenWidth * 0.5, kScreenHeight * 0.5)];
    //设置代理
    self.iflyRecognizerView.delegate = self;
}
/// 初始化导航栏
- (void)setupNav {
    GKWeakSelf(self)
    self.navigationItem.rightBarButtonItem = [GKBlockedBarButtonItem blockedBarButtonItemWithTitle:@"完成" eventHandler:^{
        [weakself.view endEditing:YES];
        GKRecordModel * model = [[GKRecordModel alloc]init];
        model.title = self.textField.text;
        model.record = self.contentTextView.text;
        model.createTime = [[NSDate new] gk_yyyyMMddHHmmTimeString];
        if (model.title.length || model.record.length) {
            // 保存到数据库中
            [[GKDatabaseManager sharedManager]insertDataFromObject:model];
        }
        [weakself dismissViewControllerAnimated:YES completion:^{
            weakself.textField.text =@"";
            weakself.contentTextView.text = @"";
        }];
    }];
    
}

#pragma mark -
#pragma mark - =============== 懒加载 ===============
- (UIToolbar *)toolBar {
    if (!_toolBar) {
        _toolBar =  [[UIToolbar alloc] init];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(endEditing)];
        doneItem.width = ceilf(self.view.frame.size.width) / 3 - 30;
        UIBarButtonItem *voiceItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"micro_small"] style:UIBarButtonItemStylePlain target:self action:@selector(voiceButtonClick)];
        voiceItem.width = ceilf(self.view.frame.size.width) / 3;
        _toolBar.frame = CGRectMake(0, 0, self.view.width, 44);
        _toolBar.tintColor = GKRGBColor(1, 152, 117);
        _toolBar.items = [NSArray arrayWithObjects:doneItem, voiceItem, nil];
    }
    return _toolBar;
}

#pragma mark -
#pragma mark - =============== 业务逻辑处理 ===============
- (void)endEditing {
    if ([self.textField isFirstResponder]) {
        self.editingTitle = YES;
        [self.textField resignFirstResponder];
    }
    if ([self.contentTextView isFirstResponder]) {
        self.editingTitle = NO;
        [self.contentTextView resignFirstResponder];
    }
}

- (IBAction)voiceButtonClick {
    [self.view endEditing:YES];
    [self startListenning];
}
- (IBAction)completeButtonClick:(UIButton *)sender {
    
    [self.view endEditing:YES];
    GKRecordModel * model = [[GKRecordModel alloc]init];
    model.title = self.textField.text;
    model.record = self.contentTextView.text;
    model.createTime = [[NSDate new] gk_yyyyMMddHHmmTimeString];
    if (model.title.length || model.record.length) {
        // 保存到数据库中
        [[GKDatabaseManager sharedManager]insertDataFromObject:model];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/// 开始识别
- (void)startListenning{
    
    //设置语音识别结果应用为普通文本领域-->@"iat"标识
    [self.iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    
    //设置前端点检测时间为5000ms
    [self.iflyRecognizerView setParameter:@"5000" forKey:[IFlySpeechConstant VAD_BOS]];
    
    //设置后断点检测最大超出时间
    [self.iflyRecognizerView setParameter:@"700" forKey:[IFlySpeechConstant VAD_EOS]];
    
    //采样率
    [self.iflyRecognizerView setParameter:@"8000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
    
    //设置返回结构中包含的标点符号
    [self.iflyRecognizerView setParameter:@"1" forKey:[IFlySpeechConstant ASR_PTT]];
    
    //设置语音识别完成后数据返回数据结构类型 @"plain" 代表 jison
    [self.iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    //开始识别语音
    [self.iflyRecognizerView start];
}

#pragma mark -
#pragma mark - =============== UITextViewDelegate ===============
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.editingTitle = YES;
}
#pragma mark -
#pragma mark - =============== UITextFieldDelegate ===============
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.editingTitle = NO;
}


#pragma mark - 语音识别代理方法
#pragma mark - =============== IFlyRecognizerViewDelegate ===============
- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast {
    //初始化结果字符串
    self.resultString = [[NSMutableString alloc] init];
    
    //数据是以字典存放到数组中的
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    for (NSString *str in dic) {
        
        [self.resultString appendFormat:@"%@", str];
    }
    if (self.editingTitle) {
        self.textField.text = [self.textField.text stringByAppendingString:self.resultString];
    }else {
        self.contentTextView.text = [self.contentTextView.text stringByAppendingString:self.resultString];
    }
}

- (void)onError:(IFlySpeechError *)error {
    GKLog(@"%@",[error errorDesc]);
}

@end
