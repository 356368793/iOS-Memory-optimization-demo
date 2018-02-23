//
//  ViewController.m
//  Memory optimization
//
//  Created by xiaochen on 2018/2/23.
//  Copyright © 2018年 xiaochen. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSArray *_titles;
}

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ViewController

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titles = @[@"Timer", @"Delegate", @"Block", @"Other"];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
#pragma ------------ 方法一 -----------------
//    // 1.获取类名
//    NSString *vcString = [NSString stringWithFormat:@"%@ViewController", _titles[indexPath.row]];
//    const char *vcName = [vcString cStringUsingEncoding:NSUTF8StringEncoding];
//    // 2.获取类对象
//    id vc = objc_getClass(vcName);
//    if (vc != nil) {
//        UIViewController *targetVc = [[vc alloc] init];
//        targetVc.title = _titles[indexPath.row];
//        // 3.判断跳转
//        [self.navigationController pushViewController:targetVc animated:YES];
//    }
    
#pragma ------------ 方法二 -----------------
    
    // 1.获取类名
    NSString *vcString = [NSString stringWithFormat:@"%@ViewController", _titles[indexPath.row]];
    // 2.获取类对象
    Class vc = NSClassFromString(vcString);
    if (vc != nil) {
        UIViewController *targetVc = [[vc alloc] init];
        targetVc.title = _titles[indexPath.row];
        // 3.判断跳转
        [self.navigationController pushViewController:targetVc animated:YES];
    }
}



@end
