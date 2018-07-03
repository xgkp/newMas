//
//  AppConfigUtils.m
//  masonry
//
//  Created by Pro on 2018/7/2.
//  Copyright © 2018年 Pro. All rights reserved.
//

#import "AppConfigUtils.h"

static AppConfigUtils * instance;

@implementation AppConfigUtils
{
    NSDictionary * cfg;
}


-(id)init
{
    self = [super init];
    if(self){
        [self loadConfig];
    }
    
    return self;
    
}

+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AppConfigUtils alloc] init];
    });
    return instance;
}


-(void)loadConfig
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];
    cfg = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
}


- (NSString *)wechatHost {
    return [cfg objectForKey:@"wechatHost"];
}

- (NSString *)appId{
    return [cfg objectForKey:@"appid"];
}

@end
