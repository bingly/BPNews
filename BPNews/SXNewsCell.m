//
//  SXNewsCell.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15-1-22.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXNewsCell.h"
#import "UIImageView+WebCache.h"
#import "Utility.h"
#import "Config.h"

@interface SXNewsCell ()

///**
// *  图片
// */
//@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
///**
// *  标题
// */
//@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
///**
// *  回复数
// */
//@property (weak, nonatomic) IBOutlet UILabel *lblReply;
///**
// *  描述
// */
//@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;
///**
// *  第二张图片（如果有的话）
// */
//@property (weak, nonatomic) IBOutlet UIImageView *imgOther1;
///**
// *  第三张图片（如果有的话）
// */
//@property (weak, nonatomic) IBOutlet UIImageView *imgOther2;


@end

@implementation SXNewsCell {

    UIImageView *imgIcon;
    UILabel *lblTitle;
    UILabel *lblReply;
    UILabel *lblSubtitle;
    UIImageView *imgOther1;
    UIImageView *imgOther2;
}

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        imgIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:imgIcon];
        
        lblTitle = [[UILabel alloc] init];
        lblTitle.font = [UIFont fontWithName:@"HYQiHei" size:16];
        [self.contentView addSubview:lblTitle];
        
        lblReply = [[UILabel alloc] init];
        lblReply.font = [UIFont fontWithName:@"HYQiHei" size:10];
        lblReply.textColor = [UIColor darkGrayColor];
        lblReply.textAlignment = NSTextAlignmentLeft;
        lblReply.layer.cornerRadius = 5;
        lblReply.layer.borderWidth = 1;
        
        lblReply.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.5].CGColor;
        
        [self.contentView addSubview:lblReply];
        
        lblSubtitle = [[UILabel alloc] init];
        lblSubtitle.font = [UIFont fontWithName:@"HYQiHei" size:13];
        lblSubtitle.textColor = [UIColor lightGrayColor];
        lblSubtitle.numberOfLines = 0;
        [self.contentView addSubview:lblSubtitle];
        
        imgOther1 = [[UIImageView alloc] init];
        [self.contentView addSubview:imgOther1];
        
        imgOther2 = [[UIImageView alloc] init];
        [self.contentView addSubview:imgOther2];
        
        PREPCONSTRAINTS(imgIcon);
        
        
        if ([reuseIdentifier isEqualToString:@"NewsCell"]) {
            
            CENTER_VIEW_V(self.contentView, imgIcon);
            ALIGN_VIEW_LEFT_CONSTANT(self.contentView, imgIcon, 8);
            ALIGN_VIEW_TOP_CONSTANT(self.contentView, imgIcon, 8);
            CONSTRAIN_WIDTH(imgIcon, 80);
            CONSTRAIN_HEIGHT(imgIcon, 60);
            
            lblTitle.frame = CGRectMake(96, 8, BP_SCREEN_WIDTH - 96, 19);
            lblSubtitle.frame = CGRectMake(96, 30, BP_SCREEN_WIDTH - 96, 40);

            PREPCONSTRAINTS(lblReply);
            ALIGN_VIEW_TOP_CONSTANT(self.contentView, lblReply, 56);
            ALIGN_VIEW_RIGHT_CONSTANT(self.contentView, lblReply, -8);
            
        } else if ([reuseIdentifier isEqualToString:@"ImagesCell"]) {
        
            NSMutableArray *constraints = [[NSMutableArray alloc] init];
            PREPCONSTRAINTS(lblTitle);
            PREPCONSTRAINTS(lblReply);
            ALIGN_VIEW_TOP_CONSTANT(self.contentView, lblTitle, 8);
            ALIGN_VIEW_TOP_CONSTANT(self.contentView, lblReply, 10);
            [constraints addObjectsFromArray:CONSTRAINTS(@"|-8-[lblTitle]-[lblReply]-8-|", NSDictionaryOfVariableBindings(lblTitle, lblReply))];

            PREPCONSTRAINTS(imgOther1);
            PREPCONSTRAINTS(imgOther2);
            ALIGN_VIEW_TOP_CONSTANT(self.contentView, imgIcon, 38);
            CONSTRAIN_HEIGHT(imgIcon, 80);
            ALIGN_VIEW_TOP_CONSTANT(self.contentView, imgOther1, 38);
            CONSTRAIN_HEIGHT(imgOther1, 80);
            ALIGN_VIEW_TOP_CONSTANT(self.contentView, imgOther2, 38);
            CONSTRAIN_HEIGHT(imgOther2, 80);
            CONSTRAIN_WIDTH(imgIcon, BP_SCREEN_WIDTH/3 - 32);
            
            [constraints addObjectsFromArray:CONSTRAINTS(@"H:|-8-[imgIcon]-[imgOther1(imgIcon)]-[imgOther2(imgIcon)]-8-|", NSDictionaryOfVariableBindings(imgIcon, imgOther1, imgOther2))];
            [self.contentView addConstraints:constraints];
        } else if ([reuseIdentifier isEqualToString:@"TopImageCell"] || [reuseIdentifier isEqualToString:@"TopTxtCell"]) {
        
            STRETCH_VIEW_H(self.contentView, imgIcon);
            ALIGN_VIEW_TOP(self.contentView, imgIcon);
            ALIGN_VIEW_BOTTOM_CONSTANT(self.contentView, imgIcon, -30);
            
            UIImageView *photoList = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"night_photoset_list_cell_icon"]];
            [self.contentView addSubview:photoList];
            PREPCONSTRAINTS(photoList);
            ALIGN_VIEW_BOTTOM_CONSTANT(self.contentView, photoList, -8);
            ALIGN_VIEW_LEFT_CONSTANT(self.contentView, photoList, 8);
            CONSTRAIN_HEIGHT(photoList, 22);
            CONSTRAIN_WIDTH(photoList, 30);
            
            PREPCONSTRAINTS(lblTitle);
            ALIGN_VIEW_LEFT_CONSTANT(self.contentView, lblTitle, 44);
            ALIGN_VIEW_BOTTOM_CONSTANT(self.contentView, lblTitle, -10);

//            UILabel *smallPoint = [[UILabel alloc] init];
//            [self.contentView addSubview:smallPoint];
//            smallPoint.text = @"···";
//            smallPoint.font = [UIFont systemFontOfSize:33];
//            PREPCONSTRAINTS(smallPoint);
//            ALIGN_VIEW_BOTTOM_CONSTANT(self.contentView, smallPoint, 10);
//            ALIGN_VIEW_RIGHT_CONSTANT(self.contentView, smallPoint, -5);

        } else if ([reuseIdentifier isEqualToString:@"BigImageCell"]) {
        
            NSMutableArray *constraints = [[NSMutableArray alloc] init];
            PREPCONSTRAINTS(lblTitle);
            PREPCONSTRAINTS(lblSubtitle);
            lblSubtitle.numberOfLines = 1;
            [constraints addObjectsFromArray:CONSTRAINTS(@"H:|-8-[lblTitle]-|", NSDictionaryOfVariableBindings(lblTitle))];
            
            
//            ALIGN_VIEW_LEFT_CONSTANT(self.contentView, lblTitle, 8);
//            ALIGN_VIEW_TOP_CONSTANT(self.contentView, lblTitle, 8);
            [constraints addObjectsFromArray:CONSTRAINTS(@"V:|-8-[lblTitle(19)]->=0-[lblSubtitle]-8-|", NSDictionaryOfVariableBindings(lblTitle, lblSubtitle))];
            [constraints addObjectsFromArray:CONSTRAINTS(@"H:|-8-[lblSubtitle]-|", NSDictionaryOfVariableBindings(lblSubtitle))];
            
            CONSTRAIN_HEIGHT(imgIcon, 102);
            [constraints addObjectsFromArray:CONSTRAINTS(@"H:|-8-[imgIcon]-8-|", NSDictionaryOfVariableBindings(imgIcon))];
            [constraints addObjectsFromArray:CONSTRAINTS(@"V:|-35-[imgIcon]-37-|", NSDictionaryOfVariableBindings(imgIcon))];
            
            [self.contentView addConstraints:constraints];
        }
        
        
    }
    return self;
}

- (void)setNewsModel:(SXNewsModel *)NewsModel
{
    _NewsModel = NewsModel;
    
//    [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:self.NewsModel.imgsrc]];
    
    [imgIcon sd_setImageWithURL:[NSURL URLWithString:self.NewsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"302"]];
    lblTitle.text = self.NewsModel.title;
    lblSubtitle.text = self.NewsModel.digest;
//    NSLog(@"imgIcon: %@", NSStringFromCGRect(imgIcon.frame));
//    NSLog(@"%@: %@", lblTitle.text, NSStringFromCGRect(lblTitle.frame));
    
    // 如果回复太多就改成几点几万
    CGFloat count =  [self.NewsModel.replyCount intValue];
    NSString *displayCount;
    if (count > 10000) {
        displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
    }else{
        displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
    }
    lblReply.text = displayCount;
    
    
    // 多图cell
    if (self.NewsModel.imgextra.count == 2) {
        
        [imgOther1 sd_setImageWithURL:[NSURL URLWithString:self.NewsModel.imgextra[0][@"imgsrc"]]];
        [imgOther2 sd_setImageWithURL:[NSURL URLWithString:self.NewsModel.imgextra[1][@"imgsrc"]]];
        
        [imgOther1 sd_setImageWithURL:[NSURL URLWithString:self.NewsModel.imgextra[0][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"302"]];
        [imgOther2 sd_setImageWithURL:[NSURL URLWithString:self.NewsModel.imgextra[1][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"302"]];
    }
    
}

#pragma mark - /************************* 类方法返回可重用ID ***************************/
+ (NSString *)idForRow:(SXNewsModel *)NewsModel
{
    if (NewsModel.hasHead && NewsModel.photosetID) {
        return @"TopImageCell";
    }else if (NewsModel.hasHead){
        return @"TopTxtCell";
    }else if (NewsModel.imgType){
        return @"BigImageCell";
    }else if (NewsModel.imgextra){
        return @"ImagesCell";
    }else{
        return @"NewsCell";
    }
}

#pragma mark - /************************* 类方法返回行高 ***************************/
+ (CGFloat)heightForRow:(SXNewsModel *)NewsModel
{
    if (NewsModel.hasHead && NewsModel.photosetID){
        return 245;
    }else if(NewsModel.hasHead) {
        return 245;
    }else if(NewsModel.imgType) {
        return 170;
    }else if (NewsModel.imgextra){
        return 130;
    }else{
        return 80;
    }
}

@end
