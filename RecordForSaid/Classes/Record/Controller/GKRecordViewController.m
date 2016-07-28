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
static const CGFloat kVoiceButtonWidth = 100;
static const CGFloat kMargin = 10;
@interface GKRecordViewController ()<IFlyRecognizerViewDelegate,UITextViewDelegate,UITextFieldDelegate>
/// 声明语音识别视图属性
@property (strong, nonatomic) IFlyRecognizerView *iflyRecognizerView;
/// 接收语音结果的数组
@property (strong, nonatomic) NSMutableString *resultString;
/// 用于显示记录内容
@property (strong, nonatomic) GKPlaceholderTextView *contentTextView;
/** 用于显示记录标题 */
@property(nonatomic, strong) UITextField *textField;
/** 开始录音按钮 */
@property(nonatomic, strong) UIButton *voiceButton;
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
    // 创建表格
    [[GKDatabaseManager sharedManager] creatTableWithClassName:[GKRecordModel class]];
    // 禁用系统默认的偏移量
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = GKRGBColor(220, 220, 220);
    [self setupNav];
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.editingTitle = YES;
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.textField.frame = CGRectMake(kMargin, kMargin + GKNavBarHeight, self.view.width - kMargin * 2, 35);
    self.contentTextView.frame = CGRectMake(kMargin, 119, self.view.width - kMargin * 2, 300);
}

/// 初始化子控件
- (void)setupSubviews {
    [self.view addSubview:self.contentTextView];
    [self.view addSubview:self.textField];
    self.iflyRecognizerView = [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
    [self.view addSubview:self.voiceButton];
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
- (GKPlaceholderTextView *)contentTextView {
    if (!_contentTextView) {
        _contentTextView =  [[GKPlaceholderTextView alloc] init];
        _contentTextView.backgroundColor = [UIColor whiteColor];
        _contentTextView.font = [UIFont systemFontOfSize:15];
        _contentTextView.placeholder = @"点击这里输入想要记录的事情";
        _contentTextView.placeholderColor = [UIColor lightGrayColor];
        _contentTextView.delegate = self;
        _contentTextView.inputAccessoryView = self.toolBar;
    }
    return _contentTextView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField =  [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
        _textField.inputAccessoryView = self.toolBar;
        _textField.delegate = self;
        _textField.placeholder = @"在这里输入标题";
    }
    return _textField;
}
- (UIButton *)voiceButton {
    if (!_voiceButton) {
        _voiceButton =  [[UIButton alloc] init];
        _voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_voiceButton setFrame:CGRectMake((self.view.frame.size.width - kVoiceButtonWidth) / 2, self.view.frame.size.height - kVoiceButtonWidth - 10, kVoiceButtonWidth, kVoiceButtonWidth)];
        [_voiceButton setTitle:@"开始录音" forState:UIControlStateNormal];
        [_voiceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _voiceButton.layer.cornerRadius = kVoiceButtonWidth * 0.5;
        _voiceButton.layer.masksToBounds = YES;
        [_voiceButton setBackgroundColor:[UIColor colorWithRed:0.458 green:0.810 blue:1.000 alpha:1.000]];
        [_voiceButton addTarget:self action:@selector(voiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_voiceButton setTintColor:[UIColor whiteColor]];
    }
    return _voiceButton;
}
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

- (void)voiceButtonClick {
    [self.view endEditing:YES];
    [self startListenning];
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
