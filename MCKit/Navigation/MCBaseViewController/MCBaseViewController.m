//
//  MCBaseViewController.m
//  MCKit <https://github.com/imegatron/MCKit>
//
//  Created by 马超(Ma Chao) on 14/7/7.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import "MCBaseViewController.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MCBehaviourDataMgr.h"


//ARC编译
#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif


@interface MCBaseViewController ()

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *hr;

@end

@implementation MCBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        if (title) {
            self.titleString = title;
            
            // Custom Title.
            //self.titleBarView.backgroundColor = [UIColor colorWithRed:51/255.0 green:153/255.0 blue:255/255.0 alpha:1];
            //self.titleBarView.backgroundColor = UIColorFromRGB(COLOR_BACKGROUND_NAVIGATIONBAR);
            self.titleBarView.backgroundImage.hidden = YES;
            self.titleBarView.titleLable.textColor = UIColorFromRGB(0xffffff);
            
            self.bInteractivePopGestureRecognizerEnable = YES;
        }
    }
    return self;
}

- (void)viewDidLoad {
    //DLog(@"MCBaseViewController viewDidLoad");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //跟踪Frame信息
    //[self trackFrame:self.view];
    
    _mainView = [[UIView alloc]init];
    _mainView.tag = 666666;
    [self.view addSubview:_mainView];
    
    if (MajorSysVer >= 7){
        [self.view setFrame:CGRectMake(0, -20, MainScreenWidth, MainScreenHeight+20)];
        [_mainView setFrame:CGRectMake(0, 0, MainScreenWidth, NavigationBarHeight + StatusbarHeight)];
    }else{
        [self.view setFrame:CGRectMake(0, 20, MainScreenWidth, MainScreenHeight-20)];
        [_mainView setFrame:CGRectMake(0, 0, MainScreenWidth, NavigationBarHeight)];
    }
    [_mainView addSubview:self.titleBarView];
    
    
    // HR
    _hr = [[UIView alloc]init];
    [_mainView addSubview:_hr];
    [_hr mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(_hr.superview);
        make.left.equalTo(_hr.superview);
        make.right.equalTo(_hr.superview);
        make.height.mas_equalTo(@1.0f);
    }];
    _hr.backgroundColor = UIColorFromRGB(0x12a3d4);
    _hr.hidden = YES;
    
    
    // Print System Infos Once.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(void){
        [self printSystemInfos];
    });
}

- (void)viewWillAppear:(BOOL)animated{
    //DLog(@"MCBaseViewController viewWillAppear");
    [super viewWillAppear:animated];
    
    // 添加页面行为记录
    //[[MCBehaviourDataMgr sharedInstance]addPageBehaviour:[MCPageBehaviour pageBehaviourWithPageName:TopVCTitle enterTime:[NSDate date]]];
    [[MCBehaviourDataMgr sharedInstance]addPageBehaviour:[MCPageBehaviour pageBehaviourWithPageName:GetVCTitle(self) enterTime:[NSDate date]]];
}

- (void)viewDidAppear:(BOOL)animated{
    //DLog(@"MCBaseViewController viewDidAppear");
    [super viewDidAppear:animated];
    /*
    APP.rootNav.interactivePopGestureRecognizer.enabled = YES;
     */
    
    /*
    DLog(@"%@", APP.rootNav.topViewController.class);
    DLog(@"%u", (unsigned int)APP.rootNav.viewControllers.count);
     */
    
    /*
    unsigned int n = (unsigned int)APP.rootNav.viewControllers.count;
    if (n <= 1) {
        APP.rootNav.interactivePopGestureRecognizer.enabled = NO;
    }
    */
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setters.

- (void)setTitleBarViewBackgroundColor:(UIColor *)titleBarViewBackgroundColor{
    _titleBarViewBackgroundColor = titleBarViewBackgroundColor;
    self.titleBarView.backgroundColor = _titleBarViewBackgroundColor;
}

- (void)setTitleLableFont:(UIFont *)titleLableFont{
    _titleLableFont = titleLableFont;
    self.titleBarView.titleLable.font = _titleLableFont;
}

- (void)setLeftButtonTitleLabelFont:(UIFont *)leftButtonTitleLabelFont{
    _leftButtonTitleLabelFont = leftButtonTitleLabelFont;
    self.titleBarView.leftButton.titleLabel.font = _leftButtonTitleLabelFont;
}

- (void)setRightButtonTitleLabelFont:(UIFont *)rightButtonTitleLabelFont{
    _rightButtonTitleLabelFont = rightButtonTitleLabelFont;
    self.titleBarView.rightButton.titleLabel.font = _rightButtonTitleLabelFont;
}

#pragma mark -
-(void)setTitleText:(NSString *)title
{
    _titleBarView.titleLable.text = title;
    
#if 0
    if(_titleBarView.switchMark && _titleBarView.switchMark.hidden == NO)
    {
        CGSize size = [title sizeWithFont:[UIFont fontWithName:kDefaultFontName size:18]];
        CGRect rect = _titleBarView.switchMark.frame;
        rect.origin.x = 85 + 5 + (150 - (150 - size.width)/2);
        _titleBarView.switchMark.frame = rect;
    }
#endif
}

- (NSString *)titleText{
    return _titleBarView.titleLable.text;
}

- (void)setSwitchIcon:(BOOL)isDown
{
    if(_titleBarView.switchMark)
    {
        if(isDown)
        {
            _titleBarView.switchMark.image = [UIImage imageNamed:@"base_nav_switch"];
        }
        else
        {
            _titleBarView.switchMark.image = [UIImage imageNamed:@"base_nav_switch1"];
        }
    }
}

//-(void)leftButtonTouchEvent
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}

-(UIButton*)getButtonByTag:(int)tag
{
    switch (tag) {
        case 1:
            return _titleBarView.leftButton;
            break;
        case 2:
            return _titleBarView.rightButton;
            break;
        case 4:
            return _titleBarView.otherButton;
            break;
        default:
            return nil;
            break;
    }
}

- (MCTitleBarView *)titleBarView {
    if (!_titleBarView) {
        _titleBarView = [[MCTitleBarView alloc]initWithTitle:self.titleString andDelegate:self];
    }
    return _titleBarView;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    return NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - GestureRecognizer
- (void)disablePopGestureRecognizer{
    /*
    APP.rootNav.interactivePopGestureRecognizer.enabled = NO;
     */
    self.bInteractivePopGestureRecognizerEnable = NO;
}

#pragma mark - Publics.
- (void)showHr{
    _hr.hidden = NO;
}

#pragma mark - System Infos.
/**
 *  打印系统信息
 */
- (void)printSystemInfos{
    
    //NSString *deviceID        = [[UIDevice currentDevice] uniqueIdentifier];//设备id
    //NSString *deviceID        = [[UIApplication sharedApplication] uuid];
    NSString *systemVersion     = [[UIDevice currentDevice] systemVersion];//系统版本
    NSString *systemModel       = [[UIDevice currentDevice] model];//是iphone 还是 ipad
    NSDictionary *dic           = [[NSBundle mainBundle] infoDictionary];//获取info－plist
    NSString *appName           = [dic objectForKey:@"CFBundleIdentifier"];//获取Bundle identifier
    NSString *appVersion        = [dic valueForKey:@"CFBundleVersion"];//获取Bundle Version
    NSString *appShortVersion   = [dic valueForKey:@"CFBundleShortVersionString"];//获取CFBundleShortVersionString
    NSDictionary *sysInfo       = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   //deviceID, @"deviceID",
                                   systemVersion, @"systemVersion",
                                   systemModel, @"systemModel",
                                   appName, @"appName",
                                   appVersion, @"appVersion",
                                   appShortVersion, @"appShortVersion",
                                   nil];
    
    DLog(@"****************** Begin System Infos *********************");
    
    for (NSString *key in sysInfo) {
        DLog(@"%@\t\t : \t\t%@", key, sysInfo[key]);
    }
    
    DLog(@"iOS System Version\t:\t%@", SysVer);
    
    DLog(@"self.view.frame:%@", NSStringFromCGRect(self.view.frame));
    DLog(@"MainScreenHeight:%@", @(MainScreenHeight));
    
    DLog(@"******************** END System Infos ********************");
}

/**
 *  跟踪Frame信息
 */
- (void)trackFrame:(UIView *)tView{
    //@weakify(self);
    [RACObserve(tView, frame) subscribeNext:^(NSString* x) {
        //@strongify(self);
        DLog(@"---------------------------------------->跟踪Frame信息, tView.frame:%@", NSStringFromCGRect(tView.frame));
    }];
}

#pragma mark - Utils.
/**
 *  获取指定viewcontroller的Title
 */
+ (NSString *)getVCTitle:(UIViewController *)vc
{
    NSString *r = @"";
    if ([vc isKindOfClass:[MCBaseViewController class]]) {
        NSString *r0 = [NSString stringWithUTF8String:object_getClassName(vc)];
        NSString *r1 = ((MCBaseViewController *)vc).pageName;
        NSString *r2 = ((MCBaseViewController *)vc).titleBarView.titleLable.text;
        r = [NSString stringWithFormat:@"%@[%@][%@]", r0, r1, r2];
    }else{
        NSString *r0 = [NSString stringWithUTF8String:object_getClassName(vc)];
        //NSString *r1 = ((MCBaseViewController *)vc).pageName;
        //NSString *r2 = ((MCBaseViewController *)vc).titleBarView.titleLable.text;
        r = [NSString stringWithFormat:@"%@[][]", r0];
    }
    
    return r;
}

/**
 *  获取topViewController的Title
 */
+ (NSString *)topVCTitle
{
    UIViewController *vc = APP.rootNav.topViewController;
    NSString *r = [[self class] getVCTitle:vc];
    return r;
}

@end
