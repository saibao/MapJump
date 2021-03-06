//
//  StudyVC.m
//  OROCSummary
//
//  Created by orilme on 2020/1/12.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "StudyVC.h"

@interface StudyVC ()

@property (nonatomic, copy) NSArray *meunArr;

@end

@implementation StudyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.navigationItem.title = @"哈哈哈~~";
    self.meunArr = @[
        // 自定义视图
        @{@"headName": @"测试",
          @"isFold": @"0",
          @"value":   @[@{@"menuName": @"测试", @"className": @"TestVC"},
                        @{@"menuName": @"渐变", @"className": @"TestShadeVC"}]}.mutableCopy,
        // 组件化
        @{@"headName": @"组件化",
          @"isFold": @"1",
          @"value": @[@{@"menuName": @"组件化-CTMediator", @"className": @"CTMediatorModuleVC"},
                      @{@"menuName": @"组件化-MGJRouter", @"className": @"MGJRouterMoudleVC"}]}.mutableCopy,
    ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.meunArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.meunArr[section][@"value"];
    return [self.meunArr[section][@"isFold"]  isEqual: @"1"] ? 0 : array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text =  self.meunArr[indexPath.section][@"value"][indexPath.row][@"menuName"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.meunArr[indexPath.section][@"value"][indexPath.row];
    UIViewController *vc = [[NSClassFromString(dict[@"className"]) alloc]init];
    vc.title = dict[@"menuName"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 60)];
    headerView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    headerBtn.frame = CGRectMake(0, 1, Screen_Width, 58);
    headerBtn.tag = section;
    headerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    headerBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    headerBtn.backgroundColor = UIColor.whiteColor;
    headerBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [headerBtn setTitle:self.meunArr[section][@"headName"] forState:UIControlStateNormal];
    [headerBtn addTarget:self action:@selector(onBtnheaderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:headerBtn];
    return headerView;
}

- (void)onBtnheaderBtnClicked:(UIButton *)sender {
    if ([self.meunArr[sender.tag][@"isFold"]  isEqual: @"1"]) {
        self.meunArr[sender.tag][@"isFold"] = @"0";
    }else {
        self.meunArr[sender.tag][@"isFold"] = @"1";
    }
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:sender.tag];//只刷新当前行
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
