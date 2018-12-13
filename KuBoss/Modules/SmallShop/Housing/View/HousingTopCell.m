//
//  HousingTopCell.m
//  CoolBroker
//
//  Created by lidan on 2018/9/14.
//  Copyright © 2018年 bxs. All rights reserved.
//

#import "HousingTopCell.h"
#import "SDCycleScrollView.h"
@interface HousingTopCell()<SDCycleScrollViewDelegate,UIScrollViewDelegate>{
    SDCycleScrollView * _cycleScrollView;
    UILabel           * _lbpage;
}



@end
@implementation HousingTopCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, MSW, MSW/750*562) delegate:self placeholderImage:[UIImage imageNamed:@"house_load_failure"]];
    _cycleScrollView.backgroundColor = [UIColor clearColor];
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    _cycleScrollView.autoScrollTimeInterval = 5.0;
    _cycleScrollView.currentPageDotColor = [UIColor clearColor]; // 自定义分页控件小圆标颜色
    _cycleScrollView.pageDotColor = [UIColor clearColor];
    [self addSubview:_cycleScrollView];
    _cycleScrollView.autoScroll=NO;

    // 滚动的页数
    _lbpage = [[UILabel alloc] init];
    _lbpage.textColor = [UIColor whiteColor];
    _lbpage.textAlignment=NSTextAlignmentCenter;
    _lbpage.backgroundColor=[UIColor blackColor];
    _lbpage.font = [UIFont systemFontOfSize:(30 / 2)];
    _lbpage.layer.masksToBounds = YES;
    _lbpage.layer.cornerRadius = 11;
    _lbpage.alpha=0.6;
    [self addSubview:_lbpage];
    [_lbpage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_cycleScrollView.mas_bottom).offset(-4);
        make.right.equalTo(_cycleScrollView.mas_right).offset((-15));
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(50);
    }];
    
    
    // 测试
    NSArray *imageNameArr = [NSArray arrayWithObjects:@"banner_default",@"banner_default",@"banner_default", nil];
    _cycleScrollView.localizationImageNamesGroup = imageNameArr;
    _lbpage.text = @"0/0";

}
-(void)setImageArray:(NSArray *)ImageArray{
    _ImageArray=ImageArray;
    
    _cycleScrollView.localizationImageNamesGroup = _ImageArray;
    
    if (_ImageArray.count == 0) {
        _lbpage.text = [NSString stringWithFormat:@"0/0"];
    } else {
        _lbpage.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)_ImageArray.count];
    }
    
    _cycleScrollView.autoScroll=NO;
    _cycleScrollView.userInteractionEnabled=YES;

}

-(void)setNoimage:(NSString *)noimage{
    NSArray *imageNameArr = [NSArray arrayWithObjects:@"house_top_img",@"house_top_img", nil];
    _cycleScrollView.localizationImageNamesGroup = imageNameArr;
    _cycleScrollView.autoScroll=NO;
    _cycleScrollView.userInteractionEnabled=NO;
    _lbpage.text = @"0/0";
    
}

#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    DLog(@"-=-点击第=-%li个",index);
//    self.clicktopimageindex(index);
    
    if (self.clicktopimageindex) {
        self.clicktopimageindex(index);
    }
    
}
- (void)scrollViewWillBeginDecelerating:(SDCycleScrollView *)scrollView didScrollToIndex:(NSInteger)index{
    if (_ImageArray.count>0) {
        _lbpage.text =[NSString stringWithFormat:@"%li/%li",index+1,_ImageArray.count];
    }else{
        _lbpage.text = @"0/0";
    }
    
}


/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    if (_ImageArray.count>0) {
        _lbpage.text =[NSString stringWithFormat:@"%li/%li",index+1,_ImageArray.count];
    }else{
        _lbpage.text = @"0/0";
    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
