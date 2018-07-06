//
//  EMUtils.m
//  driver
//
//  Created by mqs on 14-9-10.
//  Copyright (c) 2014年 成都易米网络科技有限公司. All rights reserved.
//

#import "EMUtils.h"
//#import "EMApp.h"

@implementation EMUtils

+ (BOOL) isEmpty:(NSString*)str
{
    if (str == nil) {
        return TRUE;
    }
    
    if ([str isEqual:[NSNull null]]) {
        return TRUE;
    }
    
    if ([str isKindOfClass:[NSString class]]) {
        
        if (str.length == 0) {
            return TRUE;
        }
        
        NSString *str1 = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([str1 isEqual:@"(null)"]) {
            return TRUE;
        }
        
        if ([str1 isEqual:@""]) {
            return TRUE;
        }
    }
    return FALSE;
}

+ (BOOL)isNotEmpty:(NSString *)str
{
    return ![EMUtils isEmpty:str];
}


+ (UIColor *) colorWithHex: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
#pragma mark - 手机号码验证
+(NSInteger)checkPhoneNum:(NSString *)phoneNum
{
    NSError *regularExError = NULL;
    NSRegularExpression *regularexpression = [NSRegularExpression regularExpressionWithPattern:@"^(13[0-9]|14[0-9]|15[0-9]|18[0-9]|17[0-9]|16[0-9])[0-9]{8}$" options:NSRegularExpressionCaseInsensitive error:&regularExError];
    NSInteger numberofMatch = [regularexpression numberOfMatchesInString:phoneNum
                                                                 options:NSMatchingReportProgress
                                                                   range:NSMakeRange(0, phoneNum.length)];
    return numberofMatch;
}
#pragma mark - 添加阴影
+(void)addShadowWithView:(UIView *)view{
    view.layer.cornerRadius = 5;
    view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(-2, 2);
    view.layer.shadowOpacity = 0.3;
    view.clipsToBounds = NO;
    view.layer.shouldRasterize = NO;
}
/**
 *  没数据页面
 */
+(UIView *)createNoneViewWithtext:(NSString *)text imageName:(NSString *)imageName rect:(CGRect)rect{
    
    UIView *  noneView =[[UIView alloc] initWithFrame:rect];
    noneView.backgroundColor = [UIColor whiteColor];
    UIImageView * imgView =[[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:imageName];
    [noneView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(DEVICE_WIDTH/2-70);
        make.top.mas_equalTo(140+NAVI_BAR_24);
        make.size.mas_equalTo(CGSizeMake(140 , 104));
    }];
    UILabel * label = [[UILabel alloc] init];
    label.text =text;
    label.textColor = [UIColor darkGrayColor];
    label.font =[UIFont systemFontOfSize:14];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.textAlignment = NSTextAlignmentCenter;
    [noneView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(DEVICE_WIDTH/2-70);
        make.top.mas_equalTo(imgView.mas_bottom).mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(140, 14));
    }];
    //[self.view addSubview:noneView];
    //noneView.hidden = YES;
    return noneView;
}
+ (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii view:(UIView *)view{
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    shape.frame=view.bounds;
    view.layer.mask = shape;
}
#pragma mark -自适应高度
+(CGFloat)adjustHeightWithString:(NSString *)str size:(CGSize)size font:(UIFont*)font{
    NSDictionary *attributes = @{NSFontAttributeName:font,};
    CGSize hSize = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return hSize.height;
}
+(CGFloat)adjustWidthWithString:(NSString *)str size:(CGSize)size font:(UIFont*)font{
    NSDictionary *attributes = @{NSFontAttributeName:font,};
    CGSize hSize = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return hSize.width;
}

@end
