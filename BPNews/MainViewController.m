//
//  MainViewController.m
//  BPNews
//
//  Created by bingcai on 16/1/16.
//  Copyright © 2016年 bingcai. All rights reserved.
//

#import "MainViewController.h"
#import "Utility.h"
#import "Config.h"
#import "BPTitleLabel.h"
#import "BPTableViewController.h"

@interface MainViewController () <UIScrollViewDelegate>

@end

@implementation MainViewController {

    UIScrollView *smallScrollView;
    UIScrollView *bigScrollView;
    NSArray *arrayLists;
}

#pragma mark - ******************** 懒加载
- (NSArray *)contentList {

    if (arrayLists == nil) {
        arrayLists = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewsURLs" ofType:@"plist"]];
    }
    return arrayLists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"11111"]];
    titleImageView.frame = CGRectMake(BP_SCREEN_WIDTH / 2 - 15, 20, 30, 23);
//    PREPCONSTRAINTS(titleImageView);
//    CONSTRAIN_HEIGHT(titleImageView, 23);
//    CONSTRAIN_WIDTH(titleImageView, 50);
//    ALIGN_VIEW_LEFT_CONSTANT(self.view, titleImageView, BP_SCREEN_WIDTH / 2 - 25);
    self.navigationItem.titleView = titleImageView;
    
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = BARIMAGE(@"top_navi_bell_normal", @selector(headLine));
    self.navigationItem.rightBarButtonItem = BARIMAGE(@"top_navigation_square", @selector(search));
    
    smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, BP_SCREEN_WIDTH, 40)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    smallScrollView.showsHorizontalScrollIndicator = NO;
    smallScrollView.showsVerticalScrollIndicator = NO;
//    smallScrollView.backgroundColor = [UIColor greenColor];

    [self.view addSubview:smallScrollView];

    
    bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 104, BP_SCREEN_WIDTH, BP_SCREEN_HEIGHT - 104)];
    bigScrollView.delegate = self;
//    bigScrollView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:bigScrollView];
    
    [self addController];
    [self addLabel];
    
    CGFloat contentX = self.childViewControllers.count * BP_SCREEN_WIDTH;
    bigScrollView.contentSize = CGSizeMake(contentX, 0);
    bigScrollView.pagingEnabled = YES;
    
    // 添加默认控制器
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = bigScrollView.bounds;
    [bigScrollView addSubview:vc.view];
    BPTitleLabel *label = [smallScrollView.subviews firstObject];
    label.scale = 1.0;
    bigScrollView.showsHorizontalScrollIndicator = NO;
    
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(postNitification) userInfo:nil repeats:NO];
}

- (void) postNitification {

    [[NSNotificationCenter defaultCenter]postNotificationName:@"SXAdvertisementKey" object:nil];
}

- (void) headLine {}
- (void) search {}

- (void) addController {

    for (int i = 0; i < self.contentList.count; i ++) {
        BPTableViewController *vc = [[BPTableViewController alloc] init];
        vc.title = arrayLists[i][@"title"];
        vc.urlString = arrayLists[i][@"urlString"];
        [self addChildViewController:vc];
    }
}

- (void) addLabel {

    for (int i = 0; i < 8; i ++) {
        CGFloat lblW = 70;
        CGFloat lblH = 40;
        CGFloat lblY = 0;
        CGFloat lblX = i * lblW;
        
        BPTitleLabel *label = [[BPTitleLabel alloc] init];
        UIViewController *vc = self.childViewControllers[i];
        label.text = vc.title;
        label.frame = CGRectMake(lblX, lblY, lblW, lblH);
        label.font = [UIFont fontWithName:@"HYQiHei" size:19];
        
        [smallScrollView addSubview:label];
        label.tag = i;
        label.userInteractionEnabled = YES;
        
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblClick:)]];
    }
    smallScrollView.contentSize = CGSizeMake(70 * 8, 0);
}

/** 标题栏label的点击事件 */
- (void)lblClick:(UITapGestureRecognizer *)recognizer{

    BPTitleLabel *titleLabel = (BPTitleLabel *)recognizer.view;
    
    CGFloat offsetX = titleLabel.tag * bigScrollView.frame.size.width;
    CGFloat offsetY = bigScrollView.contentOffset.y;
    CGPoint offset  = CGPointMake(offsetX, offsetY);
    
    [bigScrollView setContentOffset:offset animated:YES];
}

- (void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

    NSUInteger index = scrollView.contentOffset.x / bigScrollView.frame.size.width;
    BPTitleLabel *titleLabel = (BPTitleLabel *)smallScrollView.subviews[index];
    
    CGFloat offsetx = titleLabel.center.x - smallScrollView.frame.size.width * 0.5;
    CGFloat offsetMax = smallScrollView.contentSize.width  - smallScrollView.frame.size.width;
    
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, smallScrollView.contentOffset.y);
    [smallScrollView setContentOffset:offset animated:YES];
    BPTableViewController *newsVc = self.childViewControllers[index];
    newsVc.index = index;
    
    [smallScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    
        if (idx != index) {
            BPTitleLabel *tempLabel = smallScrollView.subviews[idx];
            tempLabel.scale = 0.0;
        }
    }];

    NSLog(@"superview: %@",newsVc.view.superview);
    NSLog(@"subview: %@", newsVc.view.subviews);
    if (newsVc.view.superview) return;
    
    newsVc.view.frame = scrollView.bounds;
    [bigScrollView addSubview:newsVc.view];
}

/** 正在滚动 */
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {

    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    
    BPTitleLabel *labelLeft = smallScrollView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < smallScrollView.subviews.count) {
        BPTitleLabel *labelRight = smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
}
@end
