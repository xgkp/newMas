//
//  EMDriverAnnotationView.h
//  sijiios
//
//  Created by 小咖Lee on 16/5/25.
//  Copyright © 2016年 easymin. All rights reserved.
//

#import "EMPointAnnotation.h"

@interface EMDriverAnnotationView : MAAnnotationView

- (id)initWithAnnotation:(EMPointAnnotation*)annotation reuseIdentifier:(NSString *)reuseIdentifier;

@end
