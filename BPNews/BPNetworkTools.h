//
//  BPNetworkTools.h
//  BPNews
//
//  Created by bingcai on 16/1/19.
//  Copyright © 2016年 bingcai. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface BPNetworkTools : AFHTTPSessionManager

+ (instancetype)sharedNetworkTools;
+ (instancetype)sharedNetworkToolsWithoutBaseUrl;

@end
