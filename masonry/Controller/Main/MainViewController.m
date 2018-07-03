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
@property(nonatomic,strong)NSArray * mutArray;

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
    
    self.mutArray = @[
                      @"config.plist文件创建和使用",
                      @"masornyProjectTest"
                      ];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  * cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = self.mutArray[indexPath.section];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return self.mutArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ConfigPlistController * vc = [[ConfigPlistController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1)
    {
        MasonryTestController * vc = [[MasonryTestController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
