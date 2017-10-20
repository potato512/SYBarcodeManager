//
//  ViewController.m
//  DemoBarcode
//
//  Created by zhangshaoyu on 16/6/14.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "ViewController.h"
#import "ScanViewController.h"
#import "SaveViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *array;
    
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"二维码的使用";
    
    self.array = @[@"生成二维码", @"扫描二维码-1", @"扫描二维码-2", @"扫描二维码-3"];
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
}
    
- (void)setUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.tableFooterView = [UIView new];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    tableView.delegate = self;
    tableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    cell.textLabel.text = self.array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.row)
    {
        SaveViewController *nextVC = [SaveViewController new];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (1 == indexPath.row)
    {
        ScanViewController *nextVC = [ScanViewController new];
        nextVC.type = 1;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (2 == indexPath.row)
    {
        ScanViewController *nextVC = [ScanViewController new];
        nextVC.type = 2;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (3 == indexPath.row)
    {
        ScanViewController *nextVC = [ScanViewController new];
        nextVC.type = 3;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}


@end
