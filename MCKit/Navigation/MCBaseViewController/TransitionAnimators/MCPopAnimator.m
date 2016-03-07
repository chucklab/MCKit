//
//  MCPopAnimator.m
//  MCKit <https://github.com/imegatron/MCKit>
//
//  Created by 马超(Ma Chao) on 2015/11/24.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import "MCPopAnimator.h"
#import "MCUtilMacros.h"

#define kPushPopViewScaleRatio      .95f
#define kPushPopViewAlpha           .5f

//ARC编译
#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

@implementation MCPopAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return .4f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [[transitionContext containerView] insertSubview:toViewController.view atIndex:0];
    
    toViewController.view.transform = CGAffineTransformMakeScale(kPushPopViewScaleRatio, kPushPopViewScaleRatio);
    toViewController.view.alpha = kPushPopViewAlpha;
    
    fromViewController.view.transform = CGAffineTransformMakeTranslation(0, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         fromViewController.view.transform = CGAffineTransformMakeTranslation(MainScreenWidth, 0);
                         
                         toViewController.view.transform = CGAffineTransformMakeScale(1.f, 1.f);
                         toViewController.view.alpha = 1.f;
                         
                     }completion:^(BOOL finished) {
                         fromViewController.view.transform = CGAffineTransformIdentity;
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end
