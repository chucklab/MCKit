//
//  MCBehaviourDataMgr.m
//  MCKit <https://github.com/imegatron/MCKit>
//
//  Created by 马超(Ma Chao) on 2015/12/31.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import "MCBehaviourDataMgr.h"
//#import "GlobalDef.h"
#import "MCUtilMacros.h"
//#import "NSObject+JSONCategories.h"
#import <YYKit/YYKit.h>


//ARC编译
#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif


#define kCacheFileName  @"BehaviourData"
#define kCacheFileExt   @"json"

@interface MCBehaviourDataMgr ()

// 页面行为数据数组
@property (nonatomic, strong) NSMutableArray *pageBehavioursArr;
// 按钮行为数据数组
@property (nonatomic, strong) NSMutableArray *btnBehavioursArr;

@end

@implementation MCBehaviourDataMgr

- (id)init{
    self = [super init];
    if (self) {
        // print log
        [self printCacheFilePath];
        
        // init
        _pageBehavioursArr = [[NSMutableArray alloc]initWithCapacity:20];
        _btnBehavioursArr = [[NSMutableArray alloc]initWithCapacity:20];
        
        // 如果不存在，创建。
        NSFileManager *fileManager=[NSFileManager defaultManager];
        if(![fileManager fileExistsAtPath:[self cacheFilePath]]){
            DLog(@"文件不存在");
            // TODO:...
        }
    }
    return self;
}

#pragma mark - 日志。
/**
 *  打印缓存文件的路径
 */
- (void)printCacheFilePath{
    // 缓存文件的路径
    DLog(@"cacheFilePath:%@", [self cacheFilePath]);
}

/**
 *  打印页面行为数据
 */
- (void)printPageBehaviourLog{
    DLog(@"********** PageBehaviour **********");
    for (MCPageBehaviour *pb in _pageBehavioursArr) {
        DLog(@"pageName:%@\tenterTime:%@",
             pb.pageName,
             [self formatDate:pb.enterTime withFormatString:nil]);
    }
}

/**
 *  打印按钮行为数据
 */
- (void)printButtonBehaviourLog{
    DLog(@"********** ButtonBehaviour **********");
    for (MCButtonBehaviour *bb in _btnBehavioursArr) {
        DLog(@"pageName:%@\tbtnName:%@\ttriggerTime:%@",
             bb.pageName,
             bb.btnName,
             [self formatDate:bb.triggerTime withFormatString:nil]);
    }
}

#pragma mark - 输出JSON数据
- (NSData *)outputJSON{
    NSData *r = nil;
    
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:20];
    
    for (MCPageBehaviour *pb in _pageBehavioursArr) {
        NSDictionary *dic = @{
                              @"recordType":@"page",
                              @"pageName":pb.pageName,
                              @"enterTime":[self formatDate:pb.enterTime withFormatString:nil],
                              };
        [arr addObject:dic];
    }
    
    for (MCButtonBehaviour *bb in _btnBehavioursArr) {
        NSDictionary *dic = @{
                              @"recordType":@"button",
                              @"pageName":bb.pageName,
                              @"btnName":bb.btnName,
                              @"triggerTime":[self formatDate:bb.triggerTime withFormatString:nil],
                              };
        [arr addObject:dic];
    }
    
    //r = [arr JSONData];
    r = [[arr jsonStringEncoded] dataUsingEncoding:NSUTF8StringEncoding];
    
    return r;
}

#pragma mark - 格式化日期和时间
/**
 *  格式化日期和时间
 *
 *  @param date      NSDate 实例
 *  @param formatStr 缺省为@"YYYY-MM-DD HH:MM:SS"
 *
 *  @return 格式化后的结果字符串
 */
- (NSString *)formatDate:(NSDate *)date withFormatString:(NSString *)formatStr{
    NSDate *senddate = date;
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    if (formatStr.length > 0) {
        [dateformatter setDateFormat:formatStr];
    }else{
        //[dateformatter setDateFormat:@"YYYYMMdd"];
        //[dateformatter setDateFormat:@"YYYY-MM-DD HH:MM:SS"];
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    NSString *locationString = [dateformatter stringFromDate:senddate];
    //NSLog(@"locationString:%@",locationString);
    return locationString;
}

#pragma mark - 缓存文件管理。
/**
 *  缓存文件的路径
 */
- (NSString *)cacheFilePath{
    // 获取Caches目录路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    //DLog(@"cachesDir:%@", cachesDir);
    
    // File Path.
    NSString *filePath = [cachesDir stringByAppendingPathComponent:kCacheFileName];
    filePath = [filePath stringByAppendingPathExtension:kCacheFileExt];
    //DLog(@"filePath:%@", filePath);
    
    return filePath;
}

/**
 *  清空缓存
 */
- (void)cleanCacheFile{
    // TODO:删除缓存文件。
}

#pragma mark - 行为记录管理.
/**
 *  添加页面行为记录
 */
- (void)addPageBehaviour:(MCPageBehaviour *)pageBehaviour {
    [_pageBehavioursArr addObject:pageBehaviour];
}

/**
 *  添加按钮行为记录
 */
- (void)addButtonBehaviour:(MCButtonBehaviour *)btnBehaviour {
    [_btnBehavioursArr addObject:btnBehaviour];
}

#pragma mark - 上传管理。
/**
 *  上传用户行为数据
 */
- (void)uploadBehaviourData{
    // TODO:...
}

#pragma mark - Singleton
+ (MCBehaviourDataMgr *)sharedInstance{
    static MCBehaviourDataMgr *sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(void){
        sharedSingleton = [[self alloc]init];
    });
    return sharedSingleton;
}

@end
