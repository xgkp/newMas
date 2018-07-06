//
//  EMPointAnnotation.h
//  sijiios
//
//  Created by 小咖Lee on 16/5/25.
//  Copyright © 2016年 easymin. All rights reserved.
//

typedef NS_ENUM(NSInteger,AnnotationType) {
    CurrentDriverType = 0,
    StartAnnotationType = 1,
    EndAnnotationType =2,
    WCAnnotationType = 3,
    DefaultAnnotationType
};

@interface EMPointAnnotation : MAPointAnnotation

@property (nonatomic, assign) AnnotationType annType;

@end
