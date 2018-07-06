//
//  EMDriverAnnotationView.m
//  sijiios
//
//  Created by 小咖Lee on 16/5/25.
//  Copyright © 2016年 easymin. All rights reserved.
//

#import "EMDriverAnnotationView.h"

@interface EMDriverAnnotationView (){
    AnnotationType type;
}

@end

@implementation EMDriverAnnotationView
/**
 *  初始化标注
 *
 *  @param annotation      当前标注
 *  @param reuseIdentifier
 *
 *  @return
 */
- (id)initWithAnnotation:(EMPointAnnotation *)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        type = annotation.annType;
        [self commitInit];
    }
    return self;
}

/**
 *  设置标注
 *
 *  @param annotation 当前标注
 */
- (void)setAnnotation:(id<MAAnnotation>)annotation{
    EMPointAnnotation * ann = (EMPointAnnotation *)annotation;
    type = ann.annType;
    [self commitInit];
}

/**
 *  初始化标注子视图
 */
- (void) commitInit{
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    CGRect rect = CGRectMake(0, 0, 64/2, 71/2);
    UIImageView * img = [[UIImageView alloc] init];
    [img setUserInteractionEnabled:YES];
    if (type == CurrentDriverType || type == DefaultAnnotationType) {
        rect = CGRectMake(0, 0, 64/2, 71/2);
        [img setFrame:rect];
        [img setImage:[UIImage imageNamed:@"workCar"]];
    }else if (type == StartAnnotationType){
        rect = CGRectMake(0, 0, 26, 26);
        [img setFrame:rect];
        [img setImage:[UIImage imageNamed:@"起点"]];
    }else if (type == EndAnnotationType){
        rect = CGRectMake(0, 0, 26, 26);
        [img setFrame:rect];
        [img setImage:[UIImage imageNamed:@"终点"]];
    }else if (type == WCAnnotationType){
        rect = CGRectMake(0, 0, 18, 30);
        [img setFrame:rect];
        [img setImage:[UIImage imageNamed:@"wc_icon"]];
    }
    [self setFrame:rect];
    [self addSubview:img];
}

@end
