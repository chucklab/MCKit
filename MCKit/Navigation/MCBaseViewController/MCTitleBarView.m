//
//  MCTitleBarView.m
//  MCKit <https://github.com/imegatron/MCKit>
//
//  Created by 马超(Ma Chao) on 14/7/7.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import "MCTitleBarView.h"
//#import "NWAdditionalView.h"
//#import "NWUtils(UI).h"
//#import "GlobalDef.h"
#import <YYKit.h>
#import "MCBaseViewController.h"
#import "MCBehaviourDataMgr.h"


//ARC编译
#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif


@implementation MCTitleBarView
@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;
@synthesize middleButton = _middleButton;
@synthesize otherButton = _otherButton;
@synthesize backgroundImage = _backgroundImage;
@synthesize delegate = _delegate;
@synthesize titleLable = _titleLable;
@synthesize switchMark = _switchMark;
@synthesize needShowLeft;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitle:(NSString *)title andDelegate:(id<TitleBarButtonDelegate>)delegate {
    self = [super init];
    if (self) {
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
            self.frame = CGRectMake(0, 0, MainScreenWidth, 44);
        } else {
            self.frame = CGRectMake(0, 0, MainScreenWidth, 44+20);
        }
        self.delegate = delegate;
        self.needShowLeft = NO;
        [self addSubview:self.backgroundImage];
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        
        [self.titleLable setText:title];
        [self addSubview:self.titleLable];
    }
    return self;
}

- (void)rotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    if (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
//        return;
//    }
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationPortrait:
        {
            
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        {
            CGRect rect = [[UIScreen mainScreen]bounds];
            if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
                [self setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.height, 44)];
            } else {
                [self setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.height, 44 + 20)];
            }
            [self.titleLable setFrame:CGRectMake((rect.size.height - 150) / 2, self.frame.size.height - 44, 150, 44)];
            [self.backgroundImage setFrame:self.bounds];
            
        }
            break;
        default:
            break;
    }
}

- (void)interfaceOrientationChanged:(InterfaceOrientationChange)orientationChange {
    switch (orientationChange) {
        case InterfaceOrientationChangeFromPortraitToLandscape:
        {
            CGRect rect = [[UIScreen mainScreen]applicationFrame];
            if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
                [self setFrame:CGRectMake(0, 20, rect.size.height, 44)];
            } else {
                [self setFrame:CGRectMake(0, 0, rect.size.height + 20, 44 + 20)];
            }
        }
            break;
        case InterfaceOrientationChangeFromLandscapeToPortrait:
        {
            CGRect rect = [[UIScreen mainScreen]applicationFrame];
            if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
                [self setFrame:CGRectMake(0, 20, rect.size.width + 20, 44)];
            } else {
                [self setFrame:CGRectMake(0, 0, rect.size.width + 20, 44 + 20)];
            }
        }
            break;
        default:
            break;
    }
    [self.titleLable setFrame:CGRectMake((self.frame.size.width - 150) / 2, self.frame.size.height - 44, 150, 44)];
    [self.rightButton setFrame:CGRectMake(self.frame.size.width - 35.5, self.frame.size.height - 30.5, 23.5, 17)];
    [self.backgroundImage setFrame:self.bounds];
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0+50, self.frame.size.height - 44, MainScreenWidth-50*2, 44)];
        //[_titleLable setFont:[UIFont fontWithName:kDefaultFontName size:18]];
        [_titleLable setTextColor:[UIColor blackColor]];
        [_titleLable setBackgroundColor:[UIColor clearColor]];
        [_titleLable setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLable;
}

- (UIImageView *)backgroundImage {
    if (!_backgroundImage) {
        if ([self.delegate respondsToSelector:@selector(setBackgroundImage)]) {
            _backgroundImage = [self.delegate setBackgroundImage];
        } else {
            _backgroundImage = [[UIImageView alloc]initWithFrame:self.frame];
            [_backgroundImage setImage:[UIImage imageNamed:@"base_nav_bg"]];
        }
    }
    return _backgroundImage;
}

- (void)setNeedSwitchIcon:(BOOL)isNeed
{
#if 0
    if(!_switchMark)
    {
        _switchMark = [[UIImageView alloc] init];
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
            [_switchMark setFrame:CGRectMake(193, 15.25, 18, 9.5)];
        } else {
            [_switchMark setFrame:CGRectMake(193, 15.25 + 20, 18, 9.5)];
        }
        CGSize size = [_titleLable.text sizeWithFont:[UIFont fontWithName:kDefaultFontName size:18]];
        CGRect rect = switchMark.frame;
        rect.origin.x = 85 + 5 + (150 - (150 - size.width)/2);
        switchMark.frame = rect;
        _switchMark.image = [UIImage imageNamed:@"base_nav_switch"];
        [self addSubview:_switchMark];
    }
    
    if (!_middleButton) {
        if ([self.delegate respondsToSelector:@selector(setMiddleButton)]) {
            _middleButton = [self.delegate setMiddleButton];
        } else {
            _middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_middleButton setFrame:CGRectMake(85, self.frame.size.height - 44, 150, 44)];

//            if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
//                [_middleButton setFrame:CGRectMake(57, 13.25, 237.5, titlebarHeight)];
//            } else {
//                [_middleButton setFrame:CGRectMake(57, 13.25 + 20, 237.5, titlebarHeight)];
//            }
            [_middleButton setBackgroundColor:[UIColor clearColor]];
        }
        [self addSubview:_middleButton];
        [_middleButton addTarget:self action:@selector(middleButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    }

    _switchMark.hidden = !isNeed;
    _middleButton.hidden = !isNeed;
    
    if(_switchMark && _switchMark.hidden == NO)
    {
        CGSize size = [self.titleLable.text sizeWithFont:[UIFont fontWithName:kDefaultFontName size:18]];
        CGRect rect = _switchMark.frame;
        rect.origin.x = 85 + 5 + (150 - (150 - size.width)/2);
        _switchMark.frame = rect;
    }
#endif
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        if ([self.delegate respondsToSelector:@selector(setLeftButton)]) {
            _leftButton = [self.delegate setLeftButton];
        } else {
            _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
            if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
                [_leftButton setFrame:CGRectMake(0, 0, kMinButtonSize*2, kMinButtonSize)];
//                [_leftButton setFrame:CGRectMake(12, 10, 15, 24)];
            } else {
                [_leftButton setFrame:CGRectMake(0, 20, kMinButtonSize*2, kMinButtonSize)];
//                [_leftButton setFrame:CGRectMake(12, 10 + 20, 15, 24)];
            }
            [_leftButton setImage:[UIImage imageNamed:@"base_nav_back"] forState:UIControlStateNormal];
            //[_leftButton setImage:[UIImage imageNamed:@"base_nav_back"] forState:UIControlStateHighlighted];
            _leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            //_leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20.f, 0, 0);
            //[_leftButton setImage:nil forState:UIControlStateNormal];
            //[_leftButton setTitle:@"取消" forState:UIControlStateNormal];
            _leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10.f, 0, 0);
            
            //_leftButton.titleLabel.font = [UIFont fontWithName:kDefaultFontName size:15];
            [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            //[_leftButton setTitleColor:[[UIColor whiteColor]colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
            
            //[_leftButton setBackgroundColor:[UIColor cyanColor] forState:UIControlStateNormal];
        }
        [_leftButton addTarget:self action:@selector(leftButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        if ([self.delegate respondsToSelector:@selector(setRightButton)]) {
            _rightButton = [self.delegate setRightButton];
        } else {
            _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
            if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
                [_rightButton setFrame:CGRectMake(MainScreenWidth - /*40.5*/kMinButtonSize*2, /*13.5 - 6.5*/0.0f, kMinButtonSize*2, kMinButtonSize)];
            } else {
                [_rightButton setFrame:CGRectMake(MainScreenWidth - /*40.5*/kMinButtonSize*2, /*13.5 - 6.5*/0.0f + 20, kMinButtonSize*2, kMinButtonSize)];
            }
            [_rightButton setImage:[UIImage imageNamed:@"base_nav_xq"] forState:UIControlStateNormal];
            _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            _rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10.f);
            //[_rightButton setImage:nil forState:UIControlStateNormal];
            //[_rightButton setTitle:@"取消" forState:UIControlStateNormal];
            _rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10.f);
            
            //_rightButton.titleLabel.font = [UIFont fontWithName:kDefaultFontName size:15];
            [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            //[_rightButton setTitleColor:[[UIColor whiteColor]colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
            
            //[_rightButton setBackgroundColor:[UIColor cyanColor] forState:UIControlStateNormal];
        }
        [_rightButton addTarget:self action:@selector(rightButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (void)leftButtonTouchUpInside {
    if ([self.delegate respondsToSelector:@selector(leftButtonTouchEvent)]) {
        [self.delegate leftButtonTouchEvent];
    }
    else{
        if (needShowLeft) {
            //[self.viewController.revealSideViewController pushViewController:APP.leftViewController onDirection:PPRevealSideDirectionLeft withOffset:25 animated:YES];
        }
        [self.viewController.navigationController popViewControllerAnimated:YES];
    }
    
    
    // 添加按钮行为记录
    [[MCBehaviourDataMgr sharedInstance]addButtonBehaviour:[MCButtonBehaviour btnBehaviourWithPageName:GetVCTitle(self.viewController) btnName:@"返回" triggerTime:[NSDate date]]];
}

- (void)rightButtonTouchUpInside {
    
    //防止多次点击
    const NSTimeInterval buttonToggleInterval = .5f;
    static NSTimeInterval lastCalledTime = -1.f;
    NSDate *nowDate = [NSDate date];
    if (lastCalledTime < 0.f) {//初始化
        //DLog(@"lastCalledTime < 0.f");
        lastCalledTime = [NSDate date].timeIntervalSince1970;
    }else{
        NSTimeInterval secondsInterval = nowDate.timeIntervalSince1970 - lastCalledTime;
        //DLog(@"secondsInterval:%@", @(secondsInterval));
        if (secondsInterval < buttonToggleInterval) {
            lastCalledTime = nowDate.timeIntervalSince1970;
            return;
        }
    }

    
    //DLog(@"-------------------------------->rightButtonTouchEvent");
    if ([self.delegate respondsToSelector:@selector(rightButtonTouchEvent)]) {
        [self.delegate rightButtonTouchEvent];
        
        
        // 添加按钮行为记录
        [[MCBehaviourDataMgr sharedInstance]addButtonBehaviour:[MCButtonBehaviour btnBehaviourWithPageName:GetVCTitle(self.viewController) btnName:@"导航右侧按钮" triggerTime:[NSDate date]]];
    }
    
    
    lastCalledTime = nowDate.timeIntervalSince1970;
}

- (void)middleButtonTouchUpInside {
    if ([self.delegate respondsToSelector:@selector(middleButtonTouchEvent)]) {
        [self.delegate middleButtonTouchEvent];
    }
}

- (void)otherButtonTouchUpInside {
    if ([self.delegate respondsToSelector:@selector(otherButtonTouchEvent)]) {
        [self.delegate otherButtonTouchEvent];
    }
}

@end
