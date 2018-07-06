//
//  MainViewController.m
//  masonry
//
//  Created by Pro on 2018/6/29.
//  Copyright © 2018年 Pro. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *classNames;
@property (nonatomic,strong) NSArray * titleNames;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initDataSource];
 
}

-(void)initUI
{
    self.navigationItem.title = @"masonyDemo";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blueColor]}];
}

-(void)initDataSource
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.titleNames = @[
                      @"config.plist文件创建和使用",
                      @"masornyProjectTest",
                      @"iOS滑块功能实现"
                      ];
    
    self.classNames = @[@"ConfigPlistController",
                        @"MasonryTestController",
                        @"SliderViewController"
                        ];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  * cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = self.titleNames[indexPath.section];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return self.titleNames.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSString *className = self.classNames[indexPath.section];
    
    UIViewController *subViewController = [[NSClassFromString(className) alloc] init];
    
    subViewController.title = self.classNames[indexPath.section];
    
    [self.navigationController pushViewController:subViewController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
