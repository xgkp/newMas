//
//  EMRushDetailView.m
//  sijiios
//
//  Created by 小咖Lee on 16/5/23.
//  Copyright © 2016年 easymin. All rights reserved.
//

#import "EMRushDetailView.h"
#import "EMPointAnnotation.h"
#import "EMDriverAnnotationView.h"
#import "EMUtils.h"

@interface EMRushDetailView ()<AMapSearchDelegate,MAMapViewDelegate>{
    double distance;
    int minute;
    NSString * startAddrStr;
    NSString * endAddrStr;
    
    MAPointAnnotation * startAnn;
    MAPointAnnotation * endAnn;
}

@property (nonatomic, strong) AMapSearchAPI *search;
@end

@implementation EMRushDetailView
/**
 *  视图初始化
 *
 *  @param frame 视图位置大小
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.searcher = [[BMKRouteSearch alloc] init];
//        self.searcher.delegate = self;
        
        self.search=[[AMapSearchAPI alloc] init];
        self.search.delegate=self;
        
        [self ggh_initSubViews];
        
    }
    return self;
}
/**
 *  视图初始化
 *
 *  @return
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self ggh_initSubViews];
    }
    return self;
}
/**
 *  初始化子视图
 */
- (void) ggh_initSubViews{
    _ggh_mainView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-20, self.frame.size.height-34)];
    [_ggh_mainView.layer setCornerRadius:4.0];
    [_ggh_mainView.layer setMasksToBounds:YES];
    [_ggh_mainView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_ggh_mainView];
    
    
    _ggh_detailView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _ggh_mainView.frame.size.width, 98)];
    [_ggh_detailView setBackgroundColor:[UIColor whiteColor]];
    [_ggh_mainView addSubview:_ggh_detailView];
    
//    UIButton *  ggh_closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-25,0, 30, 30)];
//    [ggh_closeBtn setBackgroundImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
//    [ggh_closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
//    ggh_closeBtn.backgroundColor=[UIColor whiteColor];
//    [EMUtils addShadowWithView:ggh_closeBtn];
//    [self addSubview:ggh_closeBtn];
//     ggh_closeBtn.layer.cornerRadius = 15;
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber * lat = [userDefaults objectForKey:@"CUR_LAT"];
    NSNumber * lng = [userDefaults objectForKey:@"CUR_LNG"];
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]);
    _ma_mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, _ggh_detailView.frame.size.height, _ggh_mainView.frame.size.width, _ggh_mainView.frame.size.height - _ggh_detailView.frame.size.height)];
    [_ma_mapView setDelegate:self];
    [_ma_mapView setCenterCoordinate:coor];
    [_ma_mapView showsUserLocation];
    [_ma_mapView setHidden:YES];
    [_ggh_mainView addSubview:_ma_mapView];
    
    
    _ggh_addrDetail = [[UIView alloc] initWithFrame:CGRectMake(0, _ggh_detailView.frame.size.height, _ggh_mainView.frame.size.width, _ggh_mainView.frame.size.height - _ggh_detailView.frame.size.height)];
    [_ggh_addrDetail setBackgroundColor:_ggh_mainView.backgroundColor];
    [_ggh_mainView addSubview:_ggh_addrDetail];
    
     _ggh_detaiBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 68)/2, self.frame.size.height - 68, 68, 68)];
    //[_ggh_detaiBtn.layer setCornerRadius:15];
    //[_ggh_detaiBtn.layer setMasksToBounds:YES];
    //[_ggh_detaiBtn setBackgroundColor:[UIColor whiteColor]];
//    [_ggh_detaiBtn setTitle:Localized(@"map") forState:UIControlStateNormal];
//    [_ggh_detaiBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [_ggh_detaiBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
//    [_ggh_detaiBtn setTitle:@"" forState:UIControlStateSelected];
    [_ggh_detaiBtn setBackgroundImage:[UIImage imageNamed:@"order_icon_plat"] forState:UIControlStateNormal];
    [_ggh_detaiBtn addTarget:self action:@selector(ggh_lockerOfMapView:) forControlEvents:UIControlEventTouchUpInside];
    [_ggh_detaiBtn setSelected:NO];
    [self addSubview:_ggh_detaiBtn];
   // order_icon_plat
    [self ggh_initMessageView];
    
}
/**
 *  初始化子视图
 */
- (void) ggh_initMessageView{
    
 
    _ggh_timeLabel = [[UILabel alloc] init];
    [_ggh_timeLabel setText:[NSString stringWithFormat:@"%@ 09：00",Localized(@"today")]];
    [_ggh_timeLabel setTextColor:[UIColor lightGrayColor]];
    [_ggh_timeLabel setTextAlignment:NSTextAlignmentLeft];
    [_ggh_timeLabel setFont:[UIFont systemFontOfSize:18]];
//    if (IS_IPHONE_4_OR_LESS||IS_IPHONE_5) {
//        [_ggh_timeLabel setFont:[UIFont systemFontOfSize:30]];
//    }
    [_ggh_detailView addSubview:_ggh_timeLabel];
    
    _ggh_orderType = [[UILabel alloc] init];
    [_ggh_orderType setText:Localized(@"daijia")];
    [_ggh_orderType setTextColor:ColorHex(0x0095FF)];
    [_ggh_orderType setTextAlignment:NSTextAlignmentCenter];
    [_ggh_orderType.layer setCornerRadius:4.0];
    [_ggh_orderType setBackgroundColor:COLOR(210, 233, 253, 1)];
    [_ggh_orderType.layer setMasksToBounds:YES];
    [_ggh_orderType setFont:[UIFont systemFontOfSize:13]];
    [_ggh_orderType setAdjustsFontSizeToFitWidth:YES];
    _ggh_orderType.layer.borderColor=ColorHex(0x0095FF).CGColor;
    _ggh_orderType.layer.borderWidth=1;
    [_ggh_detailView addSubview:_ggh_orderType];
    
    [_ggh_orderType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 20));
        make.top.mas_equalTo(_ggh_detailView).mas_equalTo(10);
        make.right.mas_equalTo(_ggh_detailView).mas_equalTo(-33);
    }];
    
    [_ggh_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ggh_detailView).mas_equalTo(16);
        make.left.mas_equalTo(_ggh_detailView).mas_equalTo(15);
        make.right.mas_equalTo(_ggh_orderType.mas_left).mas_equalTo(-30);
        make.height.mas_equalTo(18);
    }];
    
    UIImageView * mapImg=[[UIImageView alloc] init];
    mapImg.image=[UIImage imageNamed:@"order_icon_distance"];
    [_ggh_detailView addSubview:mapImg];
    [mapImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(19, 20));
        make.top.mas_equalTo(_ggh_timeLabel.mas_bottom).mas_equalTo(26);
        make.left.mas_equalTo(_ggh_detailView).mas_equalTo(19);
    }];
    
    UILabel * lineLabel=[[UILabel alloc] init];
    lineLabel.backgroundColor=ColorHex(0xF2F2F2);
    [_ggh_detailView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, 23));
        make.top.mas_equalTo(_ggh_timeLabel.mas_bottom).mas_equalTo(26);
        make.centerX.mas_equalTo(_ggh_detailView);
    }];
    
    UIImageView * timeImg=[[UIImageView alloc] init];
    timeImg.image=[UIImage imageNamed:@"order_icon_mins"];
    [_ggh_detailView addSubview:timeImg];
    [timeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(19, 20));
        make.top.mas_equalTo(_ggh_timeLabel.mas_bottom).mas_equalTo(26);
        make.left.mas_equalTo(lineLabel.mas_right).mas_equalTo(20);
    }];
    
    _distanceLabel =[[UILabel alloc] init];
    if (IS_IPHONE_5) {
        _distanceLabel.font=[UIFont systemFontOfSize:15];
    }else{
        _distanceLabel.font=[UIFont systemFontOfSize:17];
    }
   
    _distanceLabel.textColor=ColorHex(0x0095FFF);
    NSString * disStr = @"全程1.6公里";
    NSMutableAttributedString * disattr = [[NSMutableAttributedString alloc] initWithString:disStr];
    [disattr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 2)];
    [disattr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(disStr.length-2, 2)];
     [_ggh_detailView addSubview:_distanceLabel];
   
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ggh_timeLabel.mas_bottom).mas_equalTo(26);
        make.left.mas_equalTo(mapImg.mas_right).mas_equalTo(6);
        make.right.mas_equalTo(lineLabel.mas_left).mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    
    
    
    _timelabel =[[UILabel alloc] init];
    if (IS_IPHONE_5) {
        _timelabel.font=[UIFont systemFontOfSize:15];
    }else{
        _timelabel.font=[UIFont systemFontOfSize:17];
    }
    
    _timelabel.textColor=ColorHex(0x0095FFF);
    
    [_ggh_detailView addSubview:_timelabel];
    
    [_timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ggh_timeLabel.mas_bottom).mas_equalTo(26);
        make.left.mas_equalTo(timeImg.mas_right).mas_equalTo(6);
        make.right.mas_equalTo(_ggh_detailView).mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    UILabel *lineLabel2=[[UILabel alloc] init];
    lineLabel2.backgroundColor=ColorHex(0xF2F2F2);
    [_ggh_detailView addSubview:lineLabel2];
    [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_ggh_detailView).mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];
    
//    NSString * str = Localized(@"circuitPlan");
//    NSMutableAttributedString * attr = [[NSMutableAttributedString alloc] initWithString:str];
//    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(5, 5)];
//    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(15, 3)];
//    _ggh_descriptionLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 61, _ggh_mainView.frame.size.width, 49)];
//    [_ggh_descriptionLab setTextColor:[UIColor blackColor]];
//    [_ggh_descriptionLab setFont:[UIFont systemFontOfSize:12]];
//    //    if (IS_IPHONE_5||IS_IPHONE_4_OR_LESS) {
//    //        [_descriptionLab setFont:[UIFont systemFontOfSize:13]];
//    //    }
//    [_ggh_descriptionLab setTextAlignment:NSTextAlignmentCenter];
//    [_ggh_descriptionLab setAttributedText:attr];
//    [_ggh_detailView addSubview:_ggh_descriptionLab];
    
    
    UIImageView * startImg = [[UIImageView alloc] init];
    [startImg setImage:[UIImage imageNamed:@"order_icon_origin"]];
    [_ggh_addrDetail addSubview:startImg];
    [startImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ggh_addrDetail).mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(11, 16));
        make.left.mas_equalTo(_ggh_addrDetail).mas_equalTo(25);
    }];
    
    _ggh_startAddr = [[UILabel alloc] init];
    [_ggh_startAddr setText:Localized(@"testAddrr")];
    [_ggh_startAddr setTextColor:[UIColor blackColor]];
    [_ggh_startAddr setTextAlignment:NSTextAlignmentLeft];
    [_ggh_startAddr setNumberOfLines:0];
    [_ggh_startAddr setFont:[UIFont systemFontOfSize:20]];
    [_ggh_addrDetail addSubview:_ggh_startAddr];
    
    [_ggh_startAddr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(startImg);
        make.left.mas_equalTo(startImg.mas_right).mas_equalTo(25);
        make.right.mas_equalTo(_ggh_addrDetail).mas_equalTo(-25);
        make.height.mas_equalTo(20);
    }];
    
    
    UIImageView * endImg = [[UIImageView alloc] init];
    [endImg setImage:[UIImage imageNamed:@"order_icon_end"]];
    [_ggh_addrDetail addSubview:endImg];
   
    [endImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(startImg.mas_bottom).mas_equalTo(45);
        make.size.mas_equalTo(CGSizeMake(11, 16));
        make.left.mas_equalTo(_ggh_addrDetail).mas_equalTo(25);
    }];
    
    _ggh_endAddr = [[UILabel alloc] init];
    [_ggh_endAddr setText:Localized(@"testAddrr")];
    [_ggh_endAddr setTextColor:[UIColor blackColor]];
    [_ggh_endAddr setTextAlignment:NSTextAlignmentLeft];
    [_ggh_endAddr setNumberOfLines:0];
    [_ggh_endAddr setFont:[UIFont systemFontOfSize:20]];
    [_ggh_addrDetail addSubview:_ggh_endAddr];
    
    [_ggh_endAddr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(endImg);
        make.left.mas_equalTo(endImg.mas_right).mas_equalTo(25);
        make.right.mas_equalTo(_ggh_addrDetail).mas_equalTo(-25);
        make.height.mas_equalTo(20);
    }];
    
    
    
    _priceDetailLab = [[UILabel alloc] initWithFrame:CGRectMake(_ggh_addrDetail.frame.size.width / 2 - 100, _ggh_addrDetail.frame.size.height - 120, 200, 100)];
    [_priceDetailLab setText:@"0.0元"];
    [_priceDetailLab setTextColor:[UIColor orangeColor]];
    [_priceDetailLab setFont:[UIFont systemFontOfSize:14]];
    [_ggh_addrDetail addSubview:_priceDetailLab];
    
    
    
    
//
//    [_priceDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(_ggh_detaiBtn);
//        make.top.mas_equalTo(endImg.mas_bottom).mas_equalTo(10);
//        make.left.mas_equalTo(endImg.mas_left).mas_equalTo(-30);
//        make.right.mas_equalTo(endImg.mas_right).mas_equalTo(30);
//        make.height.mas_equalTo(40);
//    }];
    
    
}
-(void)close:(UIButton *)btn{
    self.closeBlock();
}
/**
 *  关闭、打开地图
 *
 *  @param sender
 */
- (void)ggh_lockerOfMapView:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [UIView animateWithDuration:0.3 animations:^{
            [_ggh_addrDetail setFrame:CGRectMake(0, _ggh_detailView.frame.size.height, _ggh_mainView.frame.size.width, 0)];
            [_ggh_addrDetail setAlpha:0];
            [_ma_mapView setHidden:NO];
//            [_ggh_detaiBtn setFrame:CGRectMake((self.frame.size.width - 30)/2, self.frame.size.height - 30 - (_ggh_mainView.frame.size.height - _ggh_detailView.frame.size.height), 30, 30)];
//            [_ggh_detaiBtn setBackgroundColor:[UIColor clearColor]];
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            [_ggh_addrDetail setFrame:CGRectMake(0, _ggh_detailView.frame.size.height, _ggh_mainView.frame.size.width, _ggh_mainView.frame.size.height - _ggh_detailView.frame.size.height)];
            [_ggh_addrDetail setAlpha:1];
//            [_ggh_detaiBtn setFrame:CGRectMake((self.frame.size.width - 30)/2, self.frame.size.height - 30, 30, 30)];
//            [_ggh_detaiBtn setBackgroundColor:[UIColor whiteColor]];
        } completion:^(BOOL finished) {
            [_ma_mapView setHidden:YES];
        }];
    }
}
/**
 *  加载视图数据
 *
 *  @param data 视图数据
 */
- (void)ggh_loadData:(NSDictionary *)data{
    NSString * orderType =[data objectForKey:@"orderType"];
    NSString * serviceType = [data objectForKey:@"serviceType"];
    startAddrStr = [data objectForKey:@"fromPlace"];
    endAddrStr = [data objectForKey:@"toPlace"];
    if ([EMUtils isEmpty:orderType]) {
        orderType = @"";
    }
    if ([EMUtils isEmpty:startAddrStr]) {
        startAddrStr = @"";
    }
    if ([EMUtils isEmpty:endAddrStr]) {
        endAddrStr = @"";
    }
    if ([orderType isEqualToString:@"daijia"]) {
        orderType = Localized(@"daijia");
    }
    if ([orderType isEqualToString:@"zhuanche"]) {
        if ([serviceType isEqualToString:@"tangzu"]) {
            NSNumber * bookStatus = [data objectForKey:@"bookStatus"];
            if ([bookStatus isEqual:@1]){
                orderType = @"预约用车";
            }else{
                orderType = @"专车";
            }
        }else if ([serviceType isEqualToString:@"rizu"]){
            orderType = @"日租";
        }else if ([serviceType isEqualToString:@"banrizu"]){
            orderType = @"半日租";
        }else if ([serviceType isEqualToString:@"jieji"]){
            orderType = @"接机";
        }else if ([serviceType isEqualToString:@"songji"]){
            orderType = @"送机";
        }else if ([serviceType isEqualToString:@"jiezhan"]){
            orderType = @"接站";
        }else if ([serviceType isEqualToString:@"songzhan"]){
            orderType = @"送站";
        }
    }
    if ([orderType isEqualToString:@"errand"]) {
        orderType = Localized(@"paotui");
    }
    if ([orderType isEqualToString:@"freight"]) {
        orderType = Localized(@"huoyun");
    }
    if ([orderType isEqualToString:@"zhuanxian"]) {
        NSNumber * typeNum = [data objectForKey:@"zxOrderType"];
        if ([typeNum isEqual:@0]) {
            orderType = Localized(@"pinche");
        }else if ([typeNum isEqual:@1]){
            orderType = Localized(@"baoche");
        }else if ([typeNum isEqual:@2]){
            orderType = Localized(@"jihuo");
        }
    }
    [self.ggh_orderType setText:orderType];
    [self.ggh_orderType setAdjustsFontSizeToFitWidth:YES];
    CGSize sSize  = [startAddrStr boundingRectWithSize:CGSizeMake(_ggh_startAddr.frame.size.width, 1000) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_ggh_startAddr.font} context:nil].size;
    [self.ggh_startAddr setText:startAddrStr];
    [_ggh_startAddr setFrame:CGRectMake(_ggh_startAddr.frame.origin.x, _ggh_startAddr.frame.origin.y, sSize.width, sSize.height)];
    [self.ggh_endAddr setText:endAddrStr];
    sSize = [endAddrStr boundingRectWithSize:CGSizeMake(_ggh_endAddr.frame.size.width, 1000) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_ggh_endAddr.font} context:nil].size;
    [_ggh_endAddr setFrame:CGRectMake(_ggh_endAddr.frame.origin.x, _ggh_endAddr.frame.origin.y, sSize.width, sSize.height)];
    [self.ggh_orderNumLab setText:[data objectForKey:@"orderNumber"]];
    NSNumber * timeItem = [NSNumber numberWithDouble:[[data objectForKey:@"time"] doubleValue]/1000];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[timeItem doubleValue]];
    NSDate * nowDate = [NSDate date];
    NSDateComponents *nowCalendar = [self ggh_convertDateToCalendar:nowDate];
    NSDateComponents *calendar = [self ggh_convertDateToCalendar:date];
    NSString * timeStr;
    if (calendar.day == nowCalendar.day&&calendar.month == nowCalendar.month) {
        timeStr = [NSString stringWithFormat:@"%@ %02ld:%02ld",Localized(@"today"),(long)calendar.hour,(long)calendar.minute];
    }else if(calendar.day == nowCalendar.day+1&&calendar.month == nowCalendar.month){
        timeStr = [NSString stringWithFormat:@"%@ %02ld:%02ld",Localized(@"tomorrow"),(long)calendar.hour,(long)calendar.minute];
    }else if (calendar.day == nowCalendar.day+2&&calendar.month == nowCalendar.month){
        timeStr = [NSString stringWithFormat:@"%@  %02ld:%02ld",Localized(@"afterTomorrow"),(long)calendar.hour,(long)calendar.minute];
    }else{
        timeStr = [NSString stringWithFormat:@"%ld月%ld日 %02ld:%02ld",(long)calendar.month,(long)calendar.day,(long)calendar.hour,(long)calendar.minute];
    }
    CGSize size = [timeStr boundingRectWithSize:CGSizeMake(_ggh_mainView.frame.size.width - 50, 60) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_ggh_timeLabel.font} context:nil].size;
    [_ggh_timeLabel setFrame:CGRectMake((_ggh_mainView.frame.size.width - 58 - size.width)/2, _ggh_timeLabel.frame.origin.y, size.width, 60)];
    [_ggh_timeLabel setText:timeStr];
    //NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber * startLat = [data objectForKey:@"startLat"];
    NSNumber * startLng = [data objectForKey:@"startLng"];
    NSNumber * endLat = [data objectForKey:@"endLat"];
    NSNumber * endLng = [data objectForKey:@"endLng"];
    
    CLLocationCoordinate2D startCoor = CLLocationCoordinate2DMake([startLat floatValue], [startLng floatValue]);
    CLLocationCoordinate2D endCoor = CLLocationCoordinate2DMake([endLat floatValue], [endLng floatValue]);
    [self caculateRoadDistancceWithStartCoor:startCoor endCoor:endCoor];
    
    [self ggh_addToMapWith:data];
}
- (NSDateComponents*)ggh_convertDateToCalendar:(NSDate*)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger unitFlags = NSCalendarUnitYear|
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    //int week=0;
    NSDateComponents *comps  = [calendar components:unitFlags fromDate:date];
    
    return comps;
}

/**
 *  地图上添加标注
 *
 *  @param data 标注信息
 */
- (void) ggh_addToMapWith:(NSDictionary *)data{
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber * curLat = [userDefaults objectForKey:@"CUR_LAT"];
    NSNumber * curLng = [userDefaults objectForKey:@"CUR_LNG"];
    CLLocationCoordinate2D curCoor = CLLocationCoordinate2DMake([curLat doubleValue], [curLng doubleValue]);
    
    MAPointAnnotation * myAnn = [[MAPointAnnotation alloc] init];
    [myAnn setTitle:Localized(@"whereIam")];
    [myAnn setCoordinate:curCoor];
    [_ma_mapView addAnnotation:myAnn];
    
    NSNumber * startLat = [data objectForKey:@"startLat"];
    NSNumber * startLng = [data objectForKey:@"startLng"];
    NSNumber * endLat = [data objectForKey:@"endLat"];
    NSNumber * endLng = [data objectForKey:@"endLng"];
    
    CLLocationCoordinate2D startCoor;
    if (![startLat isEqual:@0]&&![startLng isEqual:@0]&&startLat != nil&&startLng!=nil&&![startLat isEqual:[NSNull null]]&&![startLng isEqual:[NSNull null]]) {
        startCoor = CLLocationCoordinate2DMake([startLat doubleValue], [startLng doubleValue]);
        startAnn = [[MAPointAnnotation alloc] init];
       
        [startAnn setTitle:[data objectForKey:@"fromPlace"]];
        [startAnn setCoordinate:startCoor];
        [_ma_mapView addAnnotation:startAnn];
    }
    CLLocationCoordinate2D endCoor;
    if (![endLat isEqual:@0]&&![endLng isEqual:@0]&&endLng != nil&&endLat!=nil&&![endLat isEqual:[NSNull null]]&&![endLng isEqual:[NSNull null]]) {
        endCoor = CLLocationCoordinate2DMake([endLat doubleValue], [endLng doubleValue]);
       endAnn = [[MAPointAnnotation alloc] init];
       
        [endAnn setTitle:[data objectForKey:@"toPlace"]];
        [endAnn setCoordinate:endCoor];
        [_ma_mapView addAnnotation:endAnn];
    }
    [self ggh_ajustZoomLevel];
}
/**
 *  调整地图缩放比例
 */
- (void)ggh_ajustZoomLevel
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber * curlat = [userDefaults objectForKey:@"CUR_LAT"];
    NSNumber * curlng = [userDefaults objectForKey:@"CUR_LNG"];
    NSArray * anns = _ma_mapView.annotations;
    if ([anns count] > 0) {
        
        MAPointAnnotation *first = [anns objectAtIndex:0];
        
        __block CLLocationDegrees maxLat = first.coordinate.latitude;
        __block CLLocationDegrees maxLng = first.coordinate.longitude;
        
        __block CLLocationDegrees minLat = first.coordinate.latitude;
        __block CLLocationDegrees minLng = first.coordinate.longitude;
        
        [[anns copy] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            MAPointAnnotation *driver = obj;
            
            CLLocationDegrees currentLat = driver.coordinate.latitude;
            CLLocationDegrees currentLng = driver.coordinate.longitude;
            
            if (maxLat < currentLat) {
                maxLat = currentLat;
            }
            
            if (minLat > currentLat) {
                minLat = currentLat;
            }
            
            if (maxLng < currentLng) {
                maxLng = currentLng;
            }
            
            if (minLng > currentLng) {
                minLng = currentLng;
            }
            
        }];
        
        CLLocationDegrees latitudeDelta = MAX(ABS(maxLat - [curlat doubleValue]),ABS(minLat - [curlat doubleValue]));
        
        CLLocationDegrees longitudeDelta = MAX(ABS(maxLng - [curlng doubleValue]),ABS(minLng - [curlng doubleValue]));
        
        CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake([curlat doubleValue], [curlng doubleValue]);
        
        MACoordinateSpan  coordinateSpan= MACoordinateSpanMake(latitudeDelta*3.5,longitudeDelta*3.5);
        MACoordinateRegion region= MACoordinateRegionMake(centerCoordinate,coordinateSpan);
        [_ma_mapView setRegion:region animated:YES];
        [_ma_mapView setCenterCoordinate:centerCoordinate];
    }
    
}

#pragma mark - maMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation{
    if ([annotation isEqual: startAnn]) {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *nnotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        
        if (nnotationView == nil)
        {
            nnotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                         reuseIdentifier:reuseIndetifier];
        }
        
        nnotationView.image = [UIImage imageNamed:@"order_icon_staet"];
        [mapView selectAnnotation:nnotationView.annotation animated:YES];
        
        return nnotationView;
    }else if ([annotation isEqual: endAnn]) {
        static NSString *reuseIndetifier = @"annotationReuse";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:reuseIndetifier];
        }
        
        annotationView.image = [UIImage imageNamed:@"order_icon_finish"];
        [mapView selectAnnotation:annotationView.annotation animated:YES];
        
        return annotationView;
    }
    return nil;
}


/**
 *  规划线路以便计算距离，时间
 *
 *  @param startCoor 开始点
 *  @param endCoor   结束点
 */
- (void) caculateRoadDistancceWithStartCoor:(CLLocationCoordinate2D)startCoor endCoor:(CLLocationCoordinate2D)endCoor{
    
    AMapDrivingRouteSearchRequest *navi = [[AMapDrivingRouteSearchRequest alloc] init];
    
    navi.requireExtension = YES;
    navi.strategy = 5;
    /* 出发点. */
    navi.origin = [AMapGeoPoint locationWithLatitude:startCoor.latitude
                                           longitude:startCoor.longitude];
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:endCoor.latitude
                                                longitude:endCoor.longitude];
    [self.search AMapDrivingRouteSearch:navi];
    
//    //规划线路
//    BMKPlanNode *startNode = [[BMKPlanNode alloc] init];
//    startNode.pt = startCoor;
//
//    BMKPlanNode *endNode = [[BMKPlanNode alloc] init];
//    endNode.pt = endCoor;
//
//    BMKDrivingRoutePlanOption *routePlan = [[BMKDrivingRoutePlanOption alloc] init];
//    routePlan.from = startNode;
//    routePlan.to = endNode;
//    routePlan.drivingPolicy = BMK_DRIVING_TIME_FIRST;//最短时间
//    BOOL flag = [self.searcher drivingSearch:routePlan];
//    if (!flag) {
//        distance = 0;
//        minute = 0;
//        NSString * disStr = [NSString stringWithFormat:@"%.1f",distance/1000.0];
//        NSString * minStr = [NSString stringWithFormat:@"%d",minute];
////        NSString * description = [NSString stringWithFormat:@"%@%@%@，%@%@%@！",Localized(@"planLine"),disStr,Localized(@"kilometre"),Localized(@"aboutTime"),minStr,Localized(@"minute")];
////        NSMutableAttributedString * attr = [[NSMutableAttributedString alloc] initWithString:description];
////        [attr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(5, disStr.length+2)];
////        [attr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(12+disStr.length, minStr.length+2)];
////        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(5, disStr.length+2)];
////        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(12+disStr.length, minStr.length+2)];
//       // [_ggh_descriptionLab setAttributedText:attr];
//        _distanceLabel.text=[NSString stringWithFormat:@"全程%@公里",disStr];
//        _timelabel.text=[NSString stringWithFormat:@"预计%@分钟",minStr];
//    }
    
    
    
}
/* 路径规划搜索回调. */
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    if (response.route == nil)
    {
        distance = 0;
        minute = 0;
        NSString * disStr = [NSString stringWithFormat:@"%.1f",distance];
        NSString * minStr = [NSString stringWithFormat:@"%d",minute];
        NSMutableAttributedString * timeattr = [[NSMutableAttributedString alloc] initWithString:minStr];
        [timeattr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 2)];
        [timeattr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(timeattr.length-2, 2)];
        _timelabel.attributedText=timeattr;
        
        NSMutableAttributedString * disattr = [[NSMutableAttributedString alloc] initWithString:disStr];
        [disattr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 2)];
        [disattr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(disattr.length-2, 2)];
        
        _distanceLabel.attributedText=disattr;
        return;
    }
    
    //解析response获取路径信息，具体解析见 Demo
    AMapPath * path=response.route.paths[0];
    NSString * disStr = [NSString stringWithFormat:@"全程%.1f公里",path.distance/1000.0];
    NSString * minStr = [NSString stringWithFormat:@"预计%ld分钟",(long)path.duration/60];
   
    NSMutableAttributedString * timeattr = [[NSMutableAttributedString alloc] initWithString:minStr];
    [timeattr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 2)];
    [timeattr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(timeattr.length-2, 2)];
    
    NSMutableAttributedString * disattr = [[NSMutableAttributedString alloc] initWithString:disStr];
    [disattr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 2)];
    [disattr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(disattr.length-2, 2)];
    
    _timelabel.attributedText=timeattr;
    
    _distanceLabel.attributedText=disattr;

}


@end

