//
//  SmallShopDataCell.m
//  KuBoss
//
//  Created by lidan on 2018/11/27.
//  Copyright © 2018 yuyang. All rights reserved.
//

#import "SmallShopDataCell.h"

@implementation SmallShopDataCell
{
    UILabel     *_lball;  //房源总数
    UILabel     *_lbshop;  //本店角色房源

    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    UIView*leftview=[[UIView alloc]initWithFrame:CGRectMake(15, 15, 4, 13)];
    leftview.backgroundColor =RGBCOLOR(107, 123, 255);
    [self addSubview:leftview];
    
    UILabel*lbhousedata = [[UILabel alloc] initWithFrame:CGRectMake(leftview.right+6, 12, 120, 21)];
    lbhousedata.textColor =RGBCOLOR(26, 26, 26);
    lbhousedata.backgroundColor=[UIColor clearColor];
    lbhousedata.font = [UIFont systemFontOfSize:15];
    [self addSubview:lbhousedata];
    lbhousedata.text=@"微店房源数据";
    
    UIImageView*imline=[[UIImageView alloc]initWithFrame:CGRectMake(15, lbhousedata.bottom+12, MSW-15,1.5)];
    imline.image=[UIImage imageNamed:@"smallshop_Line"];
    [self addSubview:imline];
    
    UIView *bgview = [[UIView alloc] init];
    bgview.frame = CGRectMake(15, imline.bottom+12, MSW-30 , 155.8/2);
    bgview.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
    [self addSubview:bgview];
    CALayer * layer = [bgview layer];
    layer.borderColor = [[UIColor redColor] CGColor];
    layer.borderWidth = 0.0f;
    //添加四个边阴影
    bgview.layer.shadowColor = RGBCOLOR(226, 226, 226).CGColor;//阴影颜色
    bgview.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    bgview.layer.shadowOpacity = 0.5;//不透明度
    bgview.layer.shadowRadius = 5.0;//半径
    
    UILabel* lbhouse = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 100, 20)];
    lbhouse.textColor =[UIColor colorWithHex:@"#747474"];
    lbhouse.backgroundColor=[UIColor clearColor];
    lbhouse.numberOfLines=0;
    lbhouse.font = [UIFont systemFontOfSize:12];
    [bgview addSubview:lbhouse];
    lbhouse.text=@"房源总数";
    
   _lball = [[UILabel alloc] initWithFrame:CGRectMake(lbhouse.left, lbhouse.bottom+5, 120, 30)];
    _lball.textColor =kMainColor;
    _lball.backgroundColor=[UIColor clearColor];
    _lball.numberOfLines=0;
    _lball.font = [UIFont systemFontOfSize:32];
    [bgview addSubview:_lball];
    _lball.text=@"333";
    
    UILabel* lbshop = [[UILabel alloc] initWithFrame:CGRectMake(bgview.width/2+30, 10, 100, 20)];
    lbshop.textColor =[UIColor colorWithHex:@"#747474"];
    lbshop.backgroundColor=[UIColor clearColor];
    lbshop.numberOfLines=0;
    lbshop.font = [UIFont systemFontOfSize:12];
    [bgview addSubview:lbshop];
    lbshop.text=@"本店角色房源";
    
    _lbshop = [[UILabel alloc] initWithFrame:CGRectMake(lbshop.left, lbshop.bottom+5, 120, 30)];
    _lbshop.textColor =kMainColor;
    _lbshop.backgroundColor=[UIColor clearColor];
    _lbshop.numberOfLines=0;
    _lbshop.font = [UIFont systemFontOfSize:32];
    [bgview addSubview:_lbshop];
    _lbshop.text=@"333";
    
    
    UIView*leftview2=[[UIView alloc]initWithFrame:CGRectMake(15, bgview.bottom+20, 4, 13)];
    leftview2.backgroundColor =RGBCOLOR(107, 123, 255);
    [self addSubview:leftview2];
    
    UILabel*lbhousedata2 = [[UILabel alloc] initWithFrame:CGRectMake(leftview2.right+6, bgview.bottom +16, 120, 21)];
    lbhousedata2.textColor =RGBCOLOR(26, 26, 26);
    lbhousedata2.backgroundColor=[UIColor clearColor];
    lbhousedata2.font = [UIFont systemFontOfSize:15];
    [self addSubview:lbhousedata2];
    lbhousedata2.text=@"微店总访问数据";
    UIImageView*imgline=[[UIImageView alloc]initWithFrame:CGRectMake(15, lbhousedata2.bottom+12, MSW-15,1.5)];
    imgline.image=[UIImage imageNamed:@"smallshop_Line"];
    [self addSubview:imgline];
    
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"今日",@"近七日",@"近三十日",@"总",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(leftview2.left,imgline.bottom+12, 120*2, 30);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = kMainColor;
    [segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:segmentedControl];
    
    int   viewhight=110;
    
    for (int i=0; i<4; i++) {
        UIView *bgdataview=[[UIView alloc]initWithFrame:CGRectMake(i%2*MSW/2, segmentedControl.bottom+20+i/2*viewhight, MSW/2, viewhight)];
        
        UIImageView *imghead=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 30, 30)];
        imghead.image=[UIImage imageNamed:[NSString stringWithFormat:@"smallshop_head%i",i+1]];
        imghead.contentMode = UIViewContentModeScaleAspectFit;
        [bgdataview addSubview:imghead];

        UILabel* lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(imghead.right+5, imghead.top, 100, 30)];
        lbtitle.textColor =[UIColor colorWithHex:@"#747474"];
        lbtitle.backgroundColor=[UIColor clearColor];
        lbtitle.font = [UIFont systemFontOfSize:12];
        [bgdataview addSubview:lbtitle];
        
        UILabel*lbcount = [[UILabel alloc] initWithFrame:CGRectMake(lbtitle.left, lbtitle.bottom+5, 120, 30)];
        lbcount.textColor =kMainColor;
        lbcount.backgroundColor=[UIColor clearColor];
        lbcount.numberOfLines=0;
        lbcount.font = [UIFont systemFontOfSize:32];
        [bgdataview addSubview:lbcount];
        lbcount.text=@"333";
        
        UILabel* lbdes = [[UILabel alloc] initWithFrame:CGRectMake(lbcount.left, lbcount.bottom+5, MSW/2-50, 20)];
        lbdes.textColor =[UIColor colorWithHex:@"#9B9B9B"];
        lbdes.backgroundColor=[UIColor clearColor];
        lbdes.font = [UIFont systemFontOfSize:12];
        [bgdataview addSubview:lbdes];
        lbdes.text=@"门店2323  经纪人1230";
        
        if (i==0) {
//            bgview.backgroundColor=[UIColor redColor];
            lbtitle.text=@"总访客量";

        }else if (i==1){
//            bgview.backgroundColor=[UIColor yellowColor];
            lbtitle.text=@"总浏览量";

        }else if (i==2){
//            bgview.backgroundColor=[UIColor blueColor];
            lbtitle.text=@"手机号获取";

        }else if (i==3){
//            bgview.backgroundColor=[UIColor greenColor];
            lbtitle.text=@"沟通过的客户数";
            
        }
        
        [self addSubview:bgdataview];
    }
    
}

-(void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender
{
    NSInteger selecIndex = sender.selectedSegmentIndex;
 
    DLog(@"----=--- %li",selecIndex);
    if (selecIndex == 0)
    {
        
    }else{
        
        
    }
    
}
//// 一根或者多根手指开始触摸view，系统会自动调用view的下面方法
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    DLog(@"xdcfgvybhujnikmol,");
//}
//// 一根或者多根手指在view上移动，系统会自动调用view的下面方法（随着手指的移动，会持续调用该方法）
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//  
//    DLog(@"正在移动");
//}
//// 一根或者多根手指离开view，系统会自动调用view的下面方法
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    DLog(@"离开");
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
