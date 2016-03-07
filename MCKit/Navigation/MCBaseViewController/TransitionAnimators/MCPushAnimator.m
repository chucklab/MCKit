//
//  MCPushAnimator.m
//  MCKit <https://github.com/imegatron/MCKit>
//
//  Created by 马超(Ma Chao) on 2015/11/24.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import "MCPushAnimator.h"
#import "MCUtilMacros.h"

#define kPushPopViewScaleRatio      .95f
#define kPushPopViewAlpha           .5f

//ARC编译
#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

@implementation MCPushAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return .3f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [[transitionContext containerView] addSubview:toViewController.view];
    int sysMainVer = [[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue];
    if (sysMainVer >= 9) {
        CGRect rect = toViewController.view.frame;
        rect.origin.y = 0;
        toViewController.view.frame = rect;
    }
    
    toViewController.view.transform = CGAffineTransformMakeTranslation(MainScreenWidth, 0);
    
    fromViewController.view.transform = CGAffineTransformMakeScale(1.f, 1.f);
    fromViewController.view.alpha = 1.f;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         fromViewController.view.transform = CGAffineTransformMakeScale(kPushPopViewScaleRatio, kPushPopViewScaleRatio);
                         fromViewController.view.alpha = kPushPopViewAlpha;
                         
                         toViewController.view.transform = CGAffineTransformMakeTranslation(0, 0);
                         
                     }completion:^(BOOL finished) {
                         fromViewController.view.transform = CGAffineTransformIdentity;
                         fromViewController.view.alpha = 1.f;
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end
