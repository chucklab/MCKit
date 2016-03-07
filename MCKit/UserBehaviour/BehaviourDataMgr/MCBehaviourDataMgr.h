//
//  MCBehaviourDataMgr.h
//  MCKit <https://github.com/imegatron/MCKit>
//
//  Created by 马超(Ma Chao) on 2015/12/31.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//
//  File : 用户行为数据管理
//

#import <Foundation/Foundation.h>
#import "MCPageBehaviour.h"
#import "MCButtonBehaviour.h"

@interface MCBehaviourDataMgr : NSObject

#pragma mark - 行为记录管理.
/**
 *  添加页面行为记录
 */
- (void)addPageBehaviour:(MCPageBehaviour *)pageBehaviour;
/**
 *  添加按钮行为记录
 */
- (void)addButtonBehaviour:(MCButtonBehaviour *)btnBehaviour;


#pragma mark - 上传管理。
/**
 *  上传用户行为数据
 */
- (void)uploadBehaviourData;


#pragma mark - 日志。
/**
 *  打印缓存文件的路径
 */
- (void)printCacheFilePath;

/**
 *  打印页面行为数据
 */
- (void)printPageBehaviourLog;

/**
 *  打印按钮行为数据
 */
- (void)printButtonBehaviourLog;

#pragma mark - 输出JSON数据
- (NSData *)outputJSON;

#pragma mark - Singleton
+ (MCBehaviourDataMgr *)sharedInstance;

@end
