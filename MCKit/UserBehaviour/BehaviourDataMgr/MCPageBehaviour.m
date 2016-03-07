//
//  MCPageBehaviour.m
//  MCKit <https://github.com/imegatron/MCKit>
//
//  Created by 马超(Ma Chao) on 2016/1/4.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import "MCPageBehaviour.h"


//ARC编译
#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif


@implementation MCPageBehaviour

#pragma mark - Classes Utils.
/**
 *  生成一个实例。
 *
 *  @param pageName  页面名称
 *  @param enterTime 进入时间
 *
 *  @return MCPageBehaviour 实例
 */
+ (MCPageBehaviour *)pageBehaviourWithPageName:(NSString *)pageName
                                     enterTime:(NSDate *)enterTime
{
    MCPageBehaviour *r = [[MCPageBehaviour alloc]init];
    r.pageName = pageName;
    r.enterTime = enterTime;
    return r;
}

@end
