//
//  MCButtonBehaviour.m
//  MCKit <https://github.com/imegatron/MCKit>
//
//  Created by 马超(Ma Chao) on 2016/1/4.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import "MCButtonBehaviour.h"


//ARC编译
#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif


@implementation MCButtonBehaviour

#pragma mark - Classes Utils.
/**
 *  生成一个实例。
 *
 *  @param pageName     所属页面名称
 *  @param btnName      按钮名称
 *  @param triggerTime  触发时间
 *
 *  @return MCButtonBehaviour 实例
 */
+ (MCButtonBehaviour *)btnBehaviourWithPageName:(NSString *)pageName
                                        btnName:(NSString *)btnName
                                    triggerTime:(NSDate *)triggerTime
{
    MCButtonBehaviour *r = [[MCButtonBehaviour alloc]init];
    r.pageName = pageName;
    r.btnName = btnName;
    r.triggerTime = triggerTime;
    return r;
}

@end
