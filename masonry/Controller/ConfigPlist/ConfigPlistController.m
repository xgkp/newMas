//
//  ConfigPlistController.m
//  masonry
//
//  Created by Pro on 2018/7/3.
//  Copyright © 2018年 Pro. All rights reserved.
//

#import "ConfigPlistController.h"

@interface ConfigPlistController ()

@end

@implementation ConfigPlistController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"config.plist初始化方法";
    
    AppConfigUtils * configUtil  = [AppConfigUtils sharedInstance];
    NSString * justdoatest = [configUtil appId];
    NSString * wechatHost = [configUtil wechatHost];
    NSLog(@"%@,%@",justdoatest,wechatHost);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
