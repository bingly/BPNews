//
//  BPTableViewController.m
//  BPNews
//
//  Created by bingcai on 16/1/17.
//  Copyright © 2016年 bingcai. All rights reserved.
//

#import "BPTableViewController.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "BPNetworkTools.h"
#import "SXNewsModel.h"
#import "SXNewsCell.h"

#import "Utility.h"


@interface BPTableViewController()

@property(nonatomic,strong) NSMutableArray *arrayList;
@property(nonatomic,assign)BOOL update;

@end

@implementation BPTableViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.update = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(welcome) name:@"SXAdvertisementKey" object:nil];
    
    [self.tableView registerClass:[SXNewsCell class] forCellReuseIdentifier:@"NewsCell"];
    [self.tableView registerClass:[SXNewsCell class] forCellReuseIdentifier:@"ImagesCell"];
    [self.tableView registerClass:[SXNewsCell class] forCellReuseIdentifier:@"BigImageCell"];
    [self.tableView registerClass:[SXNewsCell class] forCellReuseIdentifier:@"TopTxtCell"];
    [self.tableView registerClass:[SXNewsCell class] forCellReuseIdentifier:@"TopImageCell"];
}

- (void) welcome {

    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"update"];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - /************************* 刷新数据 ***************************/
// ------下拉刷新
- (void)loadData
{
    // http://c.m.163.com//nc/article/headline/T1348647853363/0-30.html
    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/0-20.html",self.urlString];
    [self loadDataForType:1 withURL:allUrlstring];
}

// ------上拉加载
- (void)loadMoreData
{
    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/%ld-20.html",self.urlString,(self.arrayList.count - self.arrayList.count%10)];
    //    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/%ld-20.html",self.urlString,self.arrayList.count];
    [self loadDataForType:2 withURL:allUrlstring];
}

// ------公共方法
- (void)loadDataForType:(int)type withURL:(NSString *)allUrlstring
{
    [[[BPNetworkTools sharedNetworkTools]GET:allUrlstring parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        NSLog(@"%@",allUrlstring);
        NSString *key = [responseObject.keyEnumerator nextObject];
        
        NSArray *temArray = responseObject[key];
        
        NSMutableArray *arrayM = [SXNewsModel mj_objectArrayWithKeyValuesArray:temArray];

        if (type == 1) {
            self.arrayList = arrayM;
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }else if(type == 2){
            [self.arrayList addObjectsFromArray:arrayM];
            
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }] resume];
}// ------想把这里改成block来着

#pragma mark - /************************* tbv数据源方法 ***************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayList.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    SXNewsModel *newsModel = self.arrayList[indexPath.row];
    NSString *ID = [SXNewsCell idForRow:newsModel];
    
    if ((indexPath.row%20 == 0)&&(indexPath.row != 0)) {
        ID = @"NewsCell";
    }

//    SXNewsCell * cell = (SXNewsCell *)[self.tableView dequeueReusableCellWithIdentifier:@"cell"];

    
    SXNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.NewsModel = newsModel;
    
    return cell;
}

#pragma mark - /************************* tbv代理方法 ***************************/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXNewsModel *newsModel = self.arrayList[indexPath.row];
    
    CGFloat rowHeight = [SXNewsCell heightForRow:newsModel];
    
    if ((indexPath.row%20 == 0)&&(indexPath.row != 0)) {
        rowHeight = 80;
    }
    
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 刚选中又马上取消选中，格子不变色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor yellowColor];
}

@end
