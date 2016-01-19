//
//  BPTableViewController.h
//  BPNews
//
//  Created by bingcai on 16/1/17.
//  Copyright © 2016年 bingcai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPTableViewController : UITableViewController

/**
 *  url端口
 */
@property(nonatomic,copy) NSString *urlString;

@property (nonatomic,assign) NSInteger index;

@end
