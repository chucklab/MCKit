//
//  MCNavigationControllerDelegate.m
//  MCKit <https://github.com/imegatron/MCKit>
//
//  Created by 马超(Ma Chao) on 2015/11/24.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import "MCNavigationControllerDelegate.h"
#import "MCPopAnimator.h"
#import "MCPushAnimator.h"
#import "MCBaseViewController.h"
#import "MCUtilMacros.h"


//ARC编译
#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

@interface MCNavigationControllerDelegate ()

@property (weak, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) MCPopAnimator *popAnimator;
@property (strong, nonatomic) MCPushAnimator *pushAnimator;

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition* interactionController;

//@property (nonatomic, weak) UIViewController *currentShowVC;

@end

@implementation MCNavigationControllerDelegate

#pragma mark - Main Init.
- (id)initWithNavigationController:(UINavigationController *)navigationController
{
    self = [super init];
    if (self) {
        _navigationController = navigationController;
        _navigationController.view.backgroundColor = [UIColor blackColor];
        
        UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        UIView *panView = [[UIView alloc]initWithFrame:CGRectMake(0, StaticFrame.origin.y, 20.f, MainScreenHeight)];
        [panView addGestureRecognizer:panRecognizer];
        [_navigationController.view addSubview:panView];
        //[self.navigationController.view addGestureRecognizer:panRecognizer];
        
        self.popAnimator = [MCPopAnimator new];
        self.pushAnimator = [MCPushAnimator new];
    }
    return self;
}

#pragma mark - Custom Gesture.
- (void)pan:(UIPanGestureRecognizer*)recognizer
{
    if ([_navigationController.topViewController isKindOfClass:[MCBaseViewController class]]) {
        if (!((MCBaseViewController *)_navigationController.topViewController).bInteractivePopGestureRecognizerEnable) {
            return;
        }
    }
    
    
    UIView* view = self.navigationController.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:view];
        if (location.x <  CGRectGetMidX(view.bounds) && self.navigationController.viewControllers.count > 1) { // left half
            self.interactionController = [UIPercentDrivenInteractiveTransition new];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
        [self.interactionController updateInteractiveTransition:d];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([recognizer velocityInView:view].x > 0) {
            [self.interactionController finishInteractiveTransition];
        } else {
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
    }
}

#pragma mark - UINavigationControllerDelegate.

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        return self.popAnimator;
    }else if(operation == UINavigationControllerOperationPush){
        return self.pushAnimator;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactionController;
}

#if 0
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    /*
    self.interactivePopGestureRecognizer.enabled = NO;
     */
}
#endif

#if 0
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    /*
    self.interactivePopGestureRecognizer.enabled = YES;
     */
    
    // ::::BEGIN 处理侧边拖拽手势::::
    if (self.navigationController.viewControllers.count == 1)
        self.currentShowVC = nil;
    else
        self.currentShowVC = viewController;
    
    if ([viewController isKindOfClass:[MCBaseViewController class]]) {
        if (!((MCBaseViewController *)viewController).bInteractivePopGestureRecognizerEnable) {
            self.currentShowVC = nil;
        }
    }
    // ::::END 处理侧边拖拽手势::::
}
#endif

#pragma mark - UIGestureRecognizerDelegate
/*
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.navigationController.interactivePopGestureRecognizer) {
        return (self.currentShowVC == self.navigationController.topViewController);
    }
    return YES;
}
 */

#pragma mark - Singleton
/*
+ (MCNavigationControllerDelegate *)sharedInstance{
    static MCNavigationControllerDelegate *sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(void){
        sharedSingleton = [[self alloc]init];
    });
    return sharedSingleton;
}
 */


@end
