//
//  MCBaseViewController.h
//  MCKit <https://github.com/imegatron/MCKit>
//
//  Created by 马超(Ma Chao) on 14/7/7.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTitleBarView.h"
#import "MCUtilMacros.h"

@interface MCBaseViewController : UIViewController <TitleBarButtonDelegate>

@property (nonatomic,strong) MCTitleBarView *titleBarView;
@property (nonatomic,strong) NSString *titleString;

@property (nonatomic, strong) UIColor *titleBarViewBackgroundColor;
@property (nonatomic, strong) UIFont *titleLableFont;
@property (nonatomic, strong) UIFont *leftButtonTitleLabelFont;
@property (nonatomic, strong) UIFont *rightButtonTitleLabelFont;

/**
 *  页面名称、标识（用于跟踪用户行为数据）
 */
@property (nonatomic, copy) NSString *pageName;

@property (nonatomic,assign) BOOL bInteractivePopGestureRecognizerEnable;

//inits
- (id)initWithTitle:(NSString *)title;

//properties
- (void)setTitleText:(NSString *)title;
- (NSString *)titleText;
- (UIButton*)getButtonByTag:(int)tag;
- (void)setSwitchIcon:(BOOL)isDown;

#pragma mark - GestureRecognizer
/**
 *  禁用侧滑返回
 */
- (void)disablePopGestureRecognizer;
#pragma mark - Publics.
- (void)showHr;

#pragma mark - Utils.
/**
 *  获取指定viewcontroller的Title
 */
+ (NSString *)getVCTitle:(UIViewController *)vc;

/**
 *  获取topViewController的Title
 */
+ (NSString *)topVCTitle;

@end
