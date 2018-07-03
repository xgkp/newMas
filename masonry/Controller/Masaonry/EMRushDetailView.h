//
//  EMRushDetailView.h
//  sijiios
//
//  Created by 小咖Lee on 16/5/23.
//  Copyright © 2016年 easymin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMRushDetailView : UIView
/*****/
@property (nonatomic, strong) UIView * ggh_mainView;
/**
 * 详情
 */
@property (nonatomic, strong) UIView * ggh_detailView;
/**
 * 起始地、终点
 */
@property (nonatomic, strong) UIView * ggh_addrDetail;
/**
 * 订单编号
 */
@property (nonatomic, strong) UILabel * ggh_orderNumLab;
/**
 * 预约时间
 */
@property (nonatomic, strong) UILabel * ggh_timeLabel;
/**
 * 订单描述
 */
@property (nonatomic, strong) UILabel * ggh_descriptionLab;
/**
 * 距离
 */
@property (nonatomic, strong) UILabel * distanceLabel;
/**
 * 到达目的地 需要时间
 */
@property (nonatomic, strong) UILabel * timelabel;
/**
 * 起始地
 */
@property (nonatomic, strong) UILabel * ggh_startAddr;
/**
 * 目的地
 */
@property (nonatomic, strong) UILabel * ggh_endAddr;

/**
 * 地图
 */
@property (nonatomic, strong) MAMapView * ma_mapView;
/**
 * 地图展开/收拢按钮
 */
@property (nonatomic, strong) UIButton * ggh_detaiBtn;
/**
 * 订单类型
 */
@property (nonatomic, strong) UILabel * ggh_orderType;

@property (nonatomic,strong) UILabel * priceDetailLab;

@property (nonatomic, assign) CGSize ggh_size;

- (void) ggh_loadData:(NSDictionary *)data;
@property (nonatomic,copy) void (^closeBlock)();
@end

