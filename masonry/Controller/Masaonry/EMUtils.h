//
//  EMUtils.h
//  driver
//
//  Created by mqs on 14-9-10.
//  Copyright (c) 2014年 成都易米网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMResult.h"

@interface EMUtils : NSObject

+ (BOOL) isEmpty:(NSString*)str;

+ (BOOL) isNotEmpty:(NSString*)str;

+ (UIColor *)colorWithHex:(NSString*)str;

//+ (BOOL)commonErrorHandlerInView:(UIView*)view withResult:(EMResult*)result;
+(NSInteger)checkPhoneNum:(NSString *)phoneNum;
+(void)addShadowWithView:(UIView *)view;
/**
 *  没数据页面
 */
+(UIView *)createNoneViewWithtext:(NSString *)text imageName:(NSString *)imageName rect:(CGRect)rect;
//设置部分圆角
+ (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 view:(UIView *)view;
+(CGFloat)adjustHeightWithString:(NSString *)str size:(CGSize)size font:(UIFont*)font;
+(CGFloat)adjustWidthWithString:(NSString *)str size:(CGSize)size font:(UIFont*)font;
@end
