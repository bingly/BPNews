//
//  SplashViewController.m
//  BPNews
//
//  Created by bingcai on 16/1/20.
//  Copyright © 2016年 bingcai. All rights reserved.
//

#import "SplashViewController.h"
#import "SXAdManager.h"
#import "Config.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SXAdManager loadLatestAdImage];
    
    UIView *adView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIImageView *adImg = [[UIImageView alloc]initWithImage:[SXAdManager getAdImage]];
    UIImageView *adBottomImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"adBottom.png"]];
    [adView addSubview:adBottomImg];
    [adView addSubview:adImg];
    
    adBottomImg.frame = CGRectMake(0, BP_SCREEN_HEIGHT - 135, BP_SCREEN_WIDTH, 135);
    adImg.frame = CGRectMake(0, 0, BP_SCREEN_WIDTH, BP_SCREEN_HEIGHT - 135);
    
    adView.alpha = 0.99f;
    [self.view addSubview:adView];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    
    [UIView animateWithDuration:3 animations:^{
        adView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication]setStatusBarHidden:NO];
        [UIView animateWithDuration:0.5 animations:^{
            adView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [adView removeFromSuperview];
        }];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"SXAdvertisementKey" object:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
