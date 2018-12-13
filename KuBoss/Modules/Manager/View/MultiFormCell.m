//
//  MultiFormCell.m
//  Demo
//
//  Created by yuyang on 2018/5/21.
//  Copyright © 2018年 shareit. All rights reserved.
//

#import "MultiFormCell.h"
#import "UIScrollView+NoTap.h"

#define kTagView  100
#define kMax   8

@interface MultiFormCell ()

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIScrollView *rightScrollView;
@property (nonatomic, assign) BOOL isNotification;

@end
@implementation MultiFormCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    [self setup];
    return self;
}

- (void)setup
{
    

    self.nameLabel  = [[UILabel alloc]init];
    self.nameLabel .text = @"";
    self.nameLabel .font = [UIFont systemFontOfSize:12];
    self.nameLabel .textColor = KBCOLOR_WITH_HEX(0x666666);
    self.nameLabel.numberOfLines = 2;
    //self.nameLabel .adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.nameLabel ];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    

    self.rightScrollView = [[UIScrollView alloc] init];
    self.rightScrollView.delegate = self;
    self.rightScrollView.showsVerticalScrollIndicator = NO;
    self.rightScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.rightScrollView];
    
    for (int i = 1; i<kMax; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.tag = kTagView + i;
        label.text = @"";
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = KBCOLOR_WITH_HEX(0x666666);
        //label.adjustsFontSizeToFitWidth = YES;
        [self.rightScrollView addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
    }
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollMove:) name:tapCellScrollNotification object:nil];
}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isNotification = NO;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (!_isNotification) {
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:tapCellScrollNotification object:self userInfo:@{@"cellOffX":@(scrollView.contentOffset.x)}];
    }
    _isNotification = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 避开自己发的通知，只有手指拨动才会是自己的滚动
    if (!_isNotification) {
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:tapCellScrollNotification object:self userInfo:@{@"cellOffX":@(scrollView.contentOffset.x)}];
    }
    _isNotification = NO;
}

- (void)scrollViewX:(CGFloat) x
{
    [_rightScrollView setContentOffset:CGPointMake(x, 0) animated:NO];
}

-(void)scrollMove:(NSNotification*)notification
{
    NSDictionary *noticeInfo = notification.userInfo;
    NSObject *obj = notification.object;
    float x = [noticeInfo[@"cellOffX"] floatValue];
    if (obj!=self) {
        _isNotification = YES;
        [_rightScrollView setContentOffset:CGPointMake(x, 0) animated:NO];
    }else{
        _isNotification = NO;
    }
    obj = nil;
}

- (void)layoutSubviews
{
    
    CGFloat labelW = [UIScreen mainScreen].bounds.size.width / 6;
    
    self.nameLabel.frame = CGRectMake(0, 0, labelW, self.frame.size.height);
    
    self.rightScrollView.frame = CGRectMake(labelW, 0, self.frame.size.width-labelW , self.frame.size.height);
    
    self.rightScrollView.contentSize = CGSizeMake(labelW *(kMax-1),self.frame.size.height);
    
    for (int i = 1; i<kMax; i++) {
    
        UILabel *label = [self.rightScrollView viewWithTag:kTagView+i];
        if (label) {
            label.frame = CGRectMake((i-1)*(labelW), 0, labelW, self.frame.size.height);
        }
      
    }
    
}

- (void)setArrayTitle:(NSArray *)array
{
    if (array.count<kMax) {
        return;
    }
    
    for (int i = 1; i < kMax ; i++) {
        UILabel *label = [self.rightScrollView viewWithTag:kTagView+i];
        if (label) {
           label.text = [array objectAtIndex:i];
        }
    }
    self.nameLabel.text  = array.firstObject;
    [self layoutSubviews];
}

@end
