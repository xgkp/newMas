//
//  SliderViewController.m
//  masonry
//
//  Created by Pro on 2018/7/6.
//  Copyright © 2018年 Pro. All rights reserved.
//

#import "SliderViewController.h"

@interface SliderViewController ()<RSliderViewDelegate>
{
    RS_SliderView *horSlider;
    FBShimmeringView * _shimmeringView;
}

@end

@implementation SliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    horSlider = [[RS_SliderView alloc] initWithFrame:CGRectMake(15, 140, [UIScreen mainScreen].bounds.size.width - 30, 45) andOrientation:Horizontal];
    horSlider.delegate = self;
    [horSlider setHidden:YES];
    horSlider.layer.cornerRadius=23;
    [horSlider setColorsForBackground:[UIColor colorWithRed:21/255.0 green:162/255.0 blue:254/255.0 alpha:1.0]
                           foreground:[UIColor colorWithRed:99/255.0 green:190/255.0 blue:250/255.0 alpha:1.0]
                               handle:[UIColor colorWithRed:99/255.0 green:190/255.0 blue:250/255.0 alpha:1.0]
                               border:[UIColor clearColor]];
    horSlider.label.text = @"滑动 效果 > > >";
    // default font is Helvetica, size 24, so set font only if you need to change it.
    horSlider.label.font = [UIFont fontWithName:@"Helvetica" size:22];
    horSlider.label.textColor = [UIColor whiteColor];
    [self.view addSubview:horSlider];
    CGSize labSize = [self MXtYrWvSxcqJVMjem:horSlider.label MXtYrWvSxcqJVMjen:[UIFont fontWithName:@"Helvetica" size:22] MXtYrWvSxcqJVMjeo:horSlider.label.text];
    _shimmeringView = [[FBShimmeringView alloc] init];
    [_shimmeringView setCenter:horSlider.label.center];
    [_shimmeringView setBounds:CGRectMake(0, 0, labSize.width, labSize.height)];
    _shimmeringView.shimmering = YES;
    _shimmeringView.shimmeringBeginFadeDuration = 0.3;
    _shimmeringView.shimmeringOpacity = 0.3;
    [horSlider addSubview:_shimmeringView];
    [_shimmeringView setContentView:horSlider.label];
    [horSlider setHidden:NO];

    
}

- (CGSize)MXtYrWvSxcqJVMjem:(UILabel *)label MXtYrWvSxcqJVMjen:(UIFont *)font MXtYrWvSxcqJVMjeo:(NSString *)s{
    //初始化label
    [label setNumberOfLines:0];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    CGSize labelsize = [s boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return labelsize;
}


-(void)sliderValueChanged:(RS_SliderView *)sender
{
    
}
-(void)sliderValueChangeEnded:(RS_SliderView *)sender
{
    if(sender.value >= 1.0){
        NSLog(@"滑动到最终位置了~~~~~");
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
