//
//  UtilsMacro.h
//  YGYOCProject
//
//  Created by yangguangyu on 16/12/30.
//  Copyright © 2016年 yangguangyu. All rights reserved.
// http://www.jianshu.com/p/213b3b96cafe
//http://www.cocoachina.com/ios/20160713/17026.html
//http://www.code4app.com/blog-822721-628.html


#ifndef UtilsMacro_h
#define UtilsMacro_h

/*** 将服务器返回的数据写入plist ***/
#define WriteToPlist(data, filename) [data writeToFile:[NSString stringWithFormat:@"/Users/yangguanyu/Desktop/%@.plist", filename] atomically:YES];

/*** 字体 ***/
#define Font(x) [UIFont systemFontOfSize:x]
#define BoldFont(x) [UIFont boldSystemFontOfSize:x]
//*********************************************

/*** 颜色 ***/
#define RGB(r, g, b) RGBA((r), (g), (b), 255)
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#define GrayColor(v) RGB((v), (v), (v))
#define YGYRandomColor RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

//主题色黄色
#define CommonColor HexRGB(FFAD54)
//背景浅灰色
#define CommonBgColor GrayColor(206)
//按钮框颜色
#define CommonBorderColor HexColor(FFAD54)
//文字颜色
#define kTextColor ColorA(58.0, 58.0, 58.0, 1.0)
#define kNavigationBarTintColor         [UIColor blackColor] // 导航黑
#define kNavigationTintColor            [UIColor whiteColor]
#define kNavigationBarTitleColor        HEX2UICOLOR(0x6D6D6D)
#define kNavigationBarTitleLightColor   [UIColor whiteColor]
#define kNavigationBarTitleFont         [UIFont systemFontOfSize:14]
//*********************************************

/*** 日志 ***/
#ifdef DEBUG
    #define YGYLog(...) NSLog(__VA_ARGS__)
    #define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
    #define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
    #define YGYLog(...)
    #define DLog(...)
    #define ULog(...)
#endif

#define YGYLogFunc YGYLog(@"%s", __func__);

//弹出信息
#define ALERT(msg) [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show]
//*********************************************


/*** 占位图片 ***/
#define  UserIcon_PlaceholderImage [UIImage imageNamed:@"icon-sy-me2"]
#define  ProductIcon_PlaceholderImage [UIImage imageNamed:@"icon-bar-mao2"]

//*********************************************
/** 获取硬件信息*/
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_Width   ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_Height  ([UIScreen mainScreen].bounds.size.height)
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define CurrentSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
 //iPhone Device
#endif
#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif


/** 弱指针*/
#define WeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self
//弱引用/强引用  可配对引用在外面用MPWeakSelf(self)，block用MPStrongSelf(self)  也可以单独引用在外面用MPWeakSelf(self) block里面用weakself

#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime  NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)

/** 多线程GCD*/
#define GlobalGCD(block)  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),block)
#define MainGCD(block) dispatch_async(dispatch_get_main_queue(),block)

/*** 通知中心 ***/
#define NotificationCenter [NSNotificationCenter defaultCenter]

/*** UIApplication ***/
#define Application [UIApplication sharedApplication]
#define kAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define kNav ((AppDelegate *)[UIApplication sharedApplication].delegate.navigationController)
//App版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kSystemVersion [[UIDevice currentDevice] systemVersion]
#define IOS_VERSION ［[UIDevice currentDevice] systemVersion] floatValue]
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#define kISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kISiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//一些常用的缩写
#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
//#define kAppDelegate        [UIApplication sharedApplication].delegate
#define kUserDefaults      [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//拨打电话
#define canTel                 ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:"]])
#define tel(phoneNumber)       ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]])
#define telprompt(phoneNumber) ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",phoneNumber]]])

//打开URL
#define canOpenURL(appScheme) ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appScheme]])
#define openURL(appScheme) ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:appScheme]])
//*********************************************



/*** 由角度获取弧度有弧度获取角度 ***/
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

//*********************************************
//判空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))



//System
#define PasteString(string)   [[UIPasteboard generalPasteboard] setString:string];
#define PasteImage(image)     [[UIPasteboard generalPasteboard] setImage:image];


//Image
//可拉伸的图片

#define ResizableImage(name,top,left,bottom,right) [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right)]
#define ResizableImageWithMode(name,top,left,bottom,right,mode) [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right) resizingMode:mode]

#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:［NSBundle mainBundle]pathForResource:file ofType:ext］
#define IMAGE(A) [UIImage imageWithContentsOfFile:［NSBundle mainBundle] pathForResource:A ofType:nil］
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer］

//转换
#define I2S(number) [NSString stringWithFormat:@"%d",number]
#define F2S(number) [NSString stringWithFormat:@"%f",number]
#define DATE(stamp) [NSDate dateWithTimeIntervalSince1970:[stamp intValue]];


//Device
#define isIOS8 ([[[UIDevice currentDevice] systemVersion] intValue]==8)
#define isIOS9 ([[[UIDevice currentDevice] systemVersion] intValue]==9)
#define isIOS10 ([[[UIDevice currentDevice] systemVersion] intValue]==10)
#define isAfterIOS8 ([[[UIDevice currentDevice] systemVersion] intValue]>8)
#define isAfterIOS9 ([[[UIDevice currentDevice] systemVersion] intValue]>9)
#define isAfterIOS10 ([[[UIDevice currentDevice] systemVersion] intValue]>10)

#define iPhone4_OR_4s         (SCREEN_H == 480)
#define iPhone5_OR_5c_OR_5s   (SCREEN_H == 568)
#define iPhone6_OR_6s         (SCREEN_H == 667)
#define iPhone6Plus_OR_6sPlus (SCREEN_H ==736)

#define isRetina ([[UIScreen mainScreen] scale]==2)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//*********************************************

//中文字体
#define CHINESE_FONT_NAME  @"Heiti SC"
#define CHINESE_SYSTEM(x) [UIFont fontWithName:CHINESE_FONT_NAME size:x]

//不同屏幕尺寸字体适配（320，568是因为效果图为IPHONE5 如果不是则根据实际情况修改）
#define kScreenWidthRatio  (Main_Screen_Width / 320.0)
#define kScreenHeightRatio (Main_Screen_Height / 568.0)
#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
#define AdaptedFontSize(R)     CHINESE_SYSTEM(AdaptedWidth(R))



// system Frame
#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)
#define Size(w, h)                          CGSizeMake(w, h)
#define Point(x, y)                         CGPointMake(x, y)

//自定义tabbar的高度
#define kTabBarHeight                       44.0f
//自定义导航条的高度
#define kNaviBarHeight                      44.0f
//应用内默认按钮的高度
#define kDefaultButtonHeight                40.0f


#define IsPortrait ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)


#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))


//获取系统时间戳
#define getCurentTime [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]

//*********************************************
//单例化一个类
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = ［self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}


#endif


