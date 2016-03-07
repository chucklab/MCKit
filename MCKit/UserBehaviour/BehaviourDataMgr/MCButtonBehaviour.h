//
//  MCButtonBehaviour.h
//  MCKit <https://github.com/imegatron/MCKit>
//
//  Created by 马超(Ma Chao) on 2016/1/4.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCButtonBehaviour : NSObject

/**
 *  所属页面名称
 */
@property (nonatomic, copy) NSString *pageName;

/**
 *  按钮名称
 */
@property (nonatomic, copy) NSString *btnName;

/**
 *  触发时间
 */
@property (nonatomic, strong) NSDate *triggerTime;


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
                                    triggerTime:(NSDate *)triggerTime;

@end
