//
//  MCTitleBarView.h
//  MCKit <https://github.com/imegatron/MCKit>
//
//  Created by 马超(Ma Chao) on 14/7/7.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MCUtilMacros.h"

typedef enum {
    TitleBarButtonTypeNone,
    TitleBarButtonTypeLeft,
    TitleBarButtonTypeRight,
    TitleBarButtonTypeLeftAndRight,
    TitleBarButtonTypeMiddle
} TitleBarButtonType;

//@protocol TitleBarButtonTouchEventDelegate <NSObject>
//
//- (void)leftButtonTouchEvent;
//- (void)rightButtonTouchEvent;
//- (void)middleButtonTouchEvent;
//- (void)otherButtonTOuchEvent;
//
//@end

@protocol TitleBarButtonDelegate <NSObject>

@optional
- (UIImageView *)setBackgroundImage;
- (UIButton *)setLeftButton;
- (UIButton *)setRightButton;
- (UIButton *)setMiddleButton;
- (UIButton *)setOtherButton;
- (void)leftButtonTouchEvent;
- (void)rightButtonTouchEvent;
- (void)middleButtonTouchEvent;
- (void)otherButtonTouchEvent;

@end

@interface MCTitleBarView : UIView {
    TitleBarButtonType buttonType;
    UIImageView *switchMark;
}
@property (nonatomic,assign) BOOL needShowLeft;
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UIButton *middleButton;
@property (nonatomic,strong) UIButton *otherButton;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UIImageView *backgroundImage;
@property (nonatomic,assign) id<TitleBarButtonDelegate> delegate;
@property (nonatomic,strong) UIImageView *switchMark;

- (id)initWithTitle:(NSString *)title andDelegate:(id<TitleBarButtonDelegate>)delegate;
- (void)setNeedSwitchIcon:(BOOL)isNeed;
- (void)rotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;
- (void)interfaceOrientationChanged:(InterfaceOrientationChange)orientationChange;
@end
