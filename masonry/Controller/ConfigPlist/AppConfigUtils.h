//
//  AppConfigUtils.h
//  masonry
//
//  Created by Pro on 2018/7/2.
//  Copyright © 2018年 Pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfigUtils : NSObject


+ (instancetype)sharedInstance;

- (NSString *)wechatHost;

- (NSString *)appId;

@end
