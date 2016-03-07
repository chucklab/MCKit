//
//  MCUtilMacros.h
//  MCKit <https://github.com/imegatron/MCKit>
//
//  Created by 马超(Ma Chao) on 2015/11/27.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#ifndef MCUtilMacros_h
#define MCUtilMacros_h


/**
 *  Versions.
 *
 *  GNU 风格的版本号命名格式 :
 *  主版本号 . 子版本号 [. 修正版本号 [. 编译版本号 ]]
 *  英文对照 : Major_Version_Number.Minor_Version_Number[.Revision_Number[.Build_Number]]
 *  示例 : 1.2.1, 2.0, 5.0.0 build-13124
 */
#define SysVer          ([[UIDevice currentDevice] systemVersion])
#define MajorSysVer     ([[[UIDevice currentDevice] systemVersion] intValue])


/**
 *  DLog.
 */
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);


/**
 *  Memory Utils.
 */
#define SafeRelease(x)              do{if(x){[x release];x=nil;}}while(0)


/**
 *  UI Utils.
 */

//Main Screen Size.
#define MainScreenWidth             [[UIScreen mainScreen] bounds].size.width
#define MainScreenHeight            [[UIScreen mainScreen] bounds].size.height

//Adapter Utils.
#define Scale2X                     (MainScreenWidth/320.f)

//Main Size.
#define StatusbarHeight             [[UIApplication sharedApplication] statusBarFrame].size.height
#define NavigationBarHeight         44.f
#define TabbarHeight                49.f

//Util Size.
#define StaticFrame                 CGRectMake(0, NavigationBarHeight + (MajorSysVer >= 7 ? StatusbarHeight : 0), MainScreenWidth, MainScreenHeight - NavigationBarHeight - (MajorSysVer >= 7 ? StatusbarHeight : 0))
#define StaticFrameForTarBarPage    CGRectMake(0, NavigationBarHeight + (IOS_7 ? StatusbarHeight : 0), MainScreenWidth, MainScreenHeight - NavigationBarHeight - TabbarHeight - (IOS_7 ? StatusbarHeight : 0))
//最小触摸尺寸
#define kMinButtonSize              44.f

//App Stuff Utils.
#define APP                         ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define APP_KEY_WINDOW              ([UIApplication sharedApplication].keyWindow)

//Main Time Intervals.
#define APP_TIPMSG_DELAYTIME        (1.2f)

//Get VC's Title.(vc:UIViewController *)
#define GetVCTitle(vc)              ([MCBaseViewController getVCTitle:vc])
//TopViewController's Title.
#define TopVCTitle                  ([MCBaseViewController topVCTitle])

/**
 *  Color Utils.
 */
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


/**
 *  Math Utils.
 */
#define M_E         2.71828182845904523536028747135266250   /* e              */
#define M_LOG2E     1.44269504088896340735992468100189214   /* log2(e)        */
#define M_LOG10E    0.434294481903251827651128918916605082  /* log10(e)       */
#define M_LN2       0.693147180559945309417232121458176568  /* loge(2)        */
#define M_LN10      2.30258509299404568401799145468436421   /* loge(10)       */
#define M_PI        3.14159265358979323846264338327950288   /* pi             */
#define M_PI_2      1.57079632679489661923132169163975144   /* pi/2           */
#define M_PI_4      0.785398163397448309615660845819875721  /* pi/4           */
#define M_1_PI      0.318309886183790671537767526745028724  /* 1/pi           */
#define M_2_PI      0.636619772367581343075535053490057448  /* 2/pi           */
#define M_2_SQRTPI  1.12837916709551257389615890312154517   /* 2/sqrt(pi)     */
#define M_SQRT2     1.41421356237309504880168872420969808   /* sqrt(2)        */
#define M_SQRT1_2   0.707106781186547524400844362104849039  /* 1/sqrt(2)      */


/**
 *  Check nil Utils.
 */
#define CheckNilForNSNumber(n)          if (n == nil) { n = @0; }
#define CheckNilForNSString(n)          if (n == nil || [n isEqualToString:@"(null)"]) { n = @""; }


/**
 *  String Utils.
 */
//通过一个浮点数创建一个字符串，小数点后截断至两位(不是四舍五入)，然后去掉末尾多余的"0"。
#define MAKE_NO_TAIL_ZERO_FLOAT_STRING_WITH_TWO_POINT_WIDTH(x)      (@([[NSString stringWithFormat:@"%0.2f", floor(x*100.f)/100.f]doubleValue]).stringValue)
//小数点后保留2位（截断，不是四舍五入）
#define MakeStringWithFloatTrimTwo(x)                               ([NSString stringWithFormat:@"%0.2f", floor(x*100.0)/100.0])


/**
 *  Check Login Status Utils.
 */
//Check If Loged In.
#define CanActionBlock              if (![[NWConfigMgr sharedInstance]loginStatus]) { [[RootViewController sharedInstance]pushToLoginPage]; return; }


/**
 *  LValue
 */
typedef enum InterfaceOrientationChange{
    InterfaceOrientationChangeFromPortraitToLandscape,
    InterfaceOrientationChangeFromLandscapeToPortrait
} InterfaceOrientationChange;


#endif /* MCUtilMacros_h */
