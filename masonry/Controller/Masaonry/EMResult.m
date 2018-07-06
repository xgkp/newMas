//
//  EMResult.m
//  driver
//
//  Created by mqs on 14-5-19.
//  Copyright (c) 2014年 成都易米网络科技有限公司. All rights reserved.
//

#import "EMResult.h"
#import "RPJSONMapper.h"
@implementation EMResult

- (id)initWithJson:(NSDictionary *)json
{
    self = [super init];
    
    if (self) {
        
        [[RPJSONMapper sharedInstance] mapJSONValuesFrom:json toInstance:self
                                            usingMapping:@{
                                                      @"code": @"code",
                                                      @"data": @"data",
                                                      @"message":@"message"
                                                    }];
        
    }
    
    return self;
}

@end
