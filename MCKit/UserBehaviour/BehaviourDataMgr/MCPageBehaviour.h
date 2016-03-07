//
//  MCPageBehaviour.h
//  MCKit <https://github.com/imegatron/MCKit>
//
//  Created by 马超(Ma Chao) on 2016/1/4.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCPageBehaviour : NSObject

/**
 *  页面名称
 */
@property (nonatomic, copy) NSString *pageName;

/**
 *  进入时间
 */
@property (nonatomic, strong) NSDate *enterTime;

/**
 *  离开时间
 */
@property (nonatomic, strong) NSDate *leaveTime;


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
                                     enterTime:(NSDate *)enterTime;

@end
