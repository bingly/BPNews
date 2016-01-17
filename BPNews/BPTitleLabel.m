//
//  BPTitleLabel.m
//  BPNews
//
//  Created by bingcai on 16/1/17.
//  Copyright © 2016年 bingcai. All rights reserved.
//

#import "BPTitleLabel.h"

@implementation BPTitleLabel

- (instancetype) initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:18];
        
        self.scale = 0.0;
    }
    return self;
}

- (void) setScale:(CGFloat)scale {

    _scale = scale;
    
    self.textColor = [UIColor colorWithRed:scale green:0.0 blue:0.0 alpha:1];
    
    CGFloat minScale = 0.7;
    CGFloat trueScale = minScale + (1-minScale)*scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}

@end
