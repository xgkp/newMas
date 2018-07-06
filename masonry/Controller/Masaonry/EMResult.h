//
//  EMResult.h
//  driver
//
//  Created by mqs on 14-5-19.
//  Copyright (c) 2014年 成都易米网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMResult : NSObject

@property(nonatomic,strong) NSNumber *code;

@property(nonatomic,strong) NSString *message;

@property(nonatomic,strong) NSObject *data;

- (id)initWithJson:(NSDictionary*)json;

@end
