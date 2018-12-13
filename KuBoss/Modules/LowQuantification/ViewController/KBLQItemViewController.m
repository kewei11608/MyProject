//
//  KBLQItemViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/12.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQItemViewController.h"
#import "KBLQAgentView.h"
#import "ItemView.h"
#import "KBSendRequest.h"


@interface KBLQItemViewController ()
@property (nonatomic,strong)KBLQAgentView *agentView;
@property (nonatomic,assign)BOOL isMonth;
@property (nonatomic,assign)NSInteger agentid;
@property (nonatomic,assign)NSInteger lqid;
@property (nonatomic,strong)ItemView *itemView;


@end

@implementation KBLQItemViewController

- (instancetype)initBool:(BOOL) isMonth agentId:(NSInteger) agentid lqid:(NSInteger)lqid
{
    self = [super init];
    if (!self) return nil;
    self.isMonth = isMonth;
    self.agentid = agentid;
    self.lqid = lqid;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isMonth) {
      [self setCustomTitle:@"每月低量化预警"];
    }else{
       [self setCustomTitle:@"每周低量化预警"];
    }
  
    self.view.backgroundColor = KBCOLOR_WITH_HEX(0xF4F5FA);
    [self.view addSubview:self.agentView];
    [self.view addSubview:self.itemView];
    
    [self.itemView setAutoLayoutLeftToViewLeft:self.view constant:0];
    [self.itemView setAutoLayoutRightToViewRight:self.view constant:0];
    [self.itemView setAutoLayoutTopToViewBottom:self.agentView constant:15];
    [self.itemView setAutoLayoutBottomToViewBottom:self.view constant:0];
    [self api];
    @KBWeakObj(self);
    self.itemView.reminderActionBlcok = ^{
        @KBStrongObj(self);
        if (self.isMonth)
        {
            [KBUserBehavior behaviorEventId:KBRemindWeeklyLQAgentEventId];
        }
        else
        {
            [KBUserBehavior behaviorEventId:KBRemindMonthlyLQAgentEventId];
        }
        [self requestSend];
    };
    // Do any additional setup after loading the view.
}


- (void)requestSend
{
    KBSendRequest  *request = [[KBSendRequest alloc] initWithUserid:[KBUserInfoModel uid] lowId:[NSString stringWithFormat:@"%ld",self.lqid] guidance:self.itemView.textView.text];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBBaseModel *model = [KBBaseModel yy_modelWithDictionary:dict];
        if (model.code == 0) {
            [self.navigationController popViewControllerAnimated:YES];
            if(self.block) {
                self.block(self.isMonth);
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //[KBAlter  show:request.error superView:self.view];
    }];
}

- (ItemView *)itemView {
    if (!_itemView) {
        _itemView = [ItemView loadViewFrom:@"ItemView"];
    }
    return _itemView;
}

- (void)api
{
    @KBWeakObj(self);
    [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance ] lqItemAgentid:self.agentid lowquantificationrid:self.lqid success:^(KBLQItemModel * model) {
        [KBAlter hideLoadingForView:self.view];
        @KBStrongObj(self);
            [self.agentView  setItemModel:model];
        if (self.isMonth) {
              self.itemView.titleLab.text = [NSString stringWithFormat:@"每月低量化标准：%ld房 %ld客 %ld带 %ld勘",((KBLQItemSub *)model.data.grdlhsj.firstObject).availabilitynumber,((KBLQItemSub *)model.data.grdlhsj.firstObject).touristnumber,((KBLQItemSub *)model.data.grdlhsj.firstObject).takealookinumber,((KBLQItemSub *)model.data.grdlhsj.firstObject).realservicenumber];
        }
        else{
             self.itemView.titleLab.text = [NSString stringWithFormat:@"每周低量化标准：%ld房 %ld客 %ld带 %ld勘",((KBLQItemSub *)model.data.grdlhsj.firstObject).availabilitynumber,((KBLQItemSub *)model.data.grdlhsj.firstObject).touristnumber,((KBLQItemSub *)model.data.grdlhsj.firstObject).takealookinumber,((KBLQItemSub *)model.data.grdlhsj.firstObject).realservicenumber];
        }
        self.itemView.textView.text = ((KBLQItemSub *)model.data.grdlhsj.firstObject).guidance;
        self.agentView.sLab.text =  ((KBLQItemSub *)model.data.grdlhsj.firstObject).officename;
        
//        else
//        {
        self.itemView.bottomView.enabled = NO;
        self.itemView.textView.editable = NO;
        //self.itemView.inputTextLable.hidden = YES;
        self.itemView.tip.hidden = YES;
        if (((KBLQItemSub *)model.data.grdlhsj.firstObject).recordstatus == 0) {
            self.itemView.bottomView.text = @"未提醒";
            self.itemView.bottomView.textColor = KBCOLOR_WITH_HEX(0xF22424);
            self.itemView.bottomView.userInteractionEnabled = NO;
            
            if (model.data.sfjrxq == 0)
            {
                self.itemView.bottomView.enabled = YES;
                self.itemView.bottomView.text = @"发送提醒";
                self.itemView.bottomView.textColor = [UIColor whiteColor];
                self.itemView.bottomView.backgroundColor = kMainColor;
                self.itemView.textView.editable = YES;
                //self.itemView.inputTextLable.hidden = NO;
                self.itemView.tip.hidden = NO;
                self.itemView.bottomView.userInteractionEnabled = YES;

            }
            
        }
        
        else if (((KBLQItemSub *)model.data.grdlhsj.firstObject).recordstatus == 1) {
            self.itemView.bottomView.text = @"经纪人已提醒";
            self.itemView.bottomView.textColor = KBCOLOR_WITH_HEX(0x666666);
            self.itemView.bottomView.userInteractionEnabled = NO;
        }
        else if (((KBLQItemSub *)model.data.grdlhsj.firstObject).recordstatus == 2) {
            self.itemView.bottomView.text = @"经纪人已读";
            self.itemView.bottomView.textColor = kMainColor;
            self.itemView.bottomView.userInteractionEnabled = NO;
        }
        //        }
        self.itemView.inputTextLable.text = [NSString stringWithFormat:@"%ld/500字", self.itemView.textView.text.length];
        
       
        
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        if (((KBLQItemSub *)model.data.grdlhsj.firstObject).availabilityrnumber < ((KBLQItemSub *)model.data.grdlhsj.firstObject).availabilitynumber) {
            [array addObject:[KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%ld",((KBLQItemSub *)model.data.grdlhsj.firstObject).availabilityrnumber]font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0xF22424)]];
        }
        else
        {
            [array addObject:[KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%ld",((KBLQItemSub *)model.data.grdlhsj.firstObject).availabilityrnumber]font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x999999)]];
        }
        
        [array addObject:[KBAttributedStringModel initWithText:@"房 "font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x999999)]];
        
        if (((KBLQItemSub *)model.data.grdlhsj.firstObject).touristrnumber <((KBLQItemSub *)model.data.grdlhsj.firstObject).touristnumber) {
            [array addObject:[KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%ld",((KBLQItemSub *)model.data.grdlhsj.firstObject).touristrnumber]font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0xF22424)]];
        }
        else
        {
              [array addObject:[KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%ld",((KBLQItemSub *)model.data.grdlhsj.firstObject).touristrnumber]font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x999999)]];
        }
        
        [array addObject:[KBAttributedStringModel initWithText:@"客 "font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x999999)]];
        
        if (((KBLQItemSub *)model.data.grdlhsj.firstObject).takealookirnumber <((KBLQItemSub *)model.data.grdlhsj.firstObject).takealookinumber) {
            [array addObject:[KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%ld",((KBLQItemSub *)model.data.grdlhsj.firstObject).takealookirnumber]font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0xF22424)]];
        }
        else
        {
            [array addObject:[KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%ld",((KBLQItemSub *)model.data.grdlhsj.firstObject).takealookirnumber]font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x999999)]];
        }
        
        [array addObject:[KBAttributedStringModel initWithText:@"带  "font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x999999)]];
        
        if (((KBLQItemSub *)model.data.grdlhsj.firstObject).realservicernumber < ((KBLQItemSub *)model.data.grdlhsj.firstObject).realservicenumber) {
            [array addObject:[KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%ld",((KBLQItemSub *)model.data.grdlhsj.firstObject).realservicernumber]font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0xF22424)]];
        }
        else
        {
            [array addObject:[KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%ld",((KBLQItemSub *)model.data.grdlhsj.firstObject).realservicernumber]font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x999999)]];
        }
        
        [array addObject:[KBAttributedStringModel initWithText:@"勘  "font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x999999)]];
        self.agentView.tLab.attributedText = [KBAttributedStringTool conversionAttributedStringFromModelArray:array];
        //self.agentView.tLab.text =  [NSString stringWithFormat:@"%ld房 %ld客 %ld带 %ld勘",((KBLQItemSub *)model.data.grdlhsj.firstObject).availabilityrnumber,((KBLQItemSub *)model.data.grdlhsj.firstObject).touristrnumber,((KBLQItemSub *)model.data.grdlhsj.firstObject).takealookirnumber,((KBLQItemSub *)model.data.grdlhsj.firstObject).realservicernumber];
        [self handle: ((KBLQItemSub *)model.data.grdlhsj.firstObject).lqtagging];
    } fail:^(NSError *error) {
        [KBAlter hideLoadingForView:self.view];
    }];
}

- (void)handle:(NSString *)string
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    NSArray *array = [string componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
    NSLog(@"array:%@",array);
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
        lable.text =[self getLableText:obj];
        lable.font = [UIFont systemFontOfSize:12];
        lable.frame = CGRectMake(0, 0, [lable.text kb_WidthWithFontSize:12] + 10, 20);
        lable.textColor = KBCOLOR_WITH_HEX(0xFF3F34);
        lable.layer.borderColor = KBCOLOR_WITH_HEX(0xFF3F34).CGColor;
        lable.layer.borderWidth = 1;
        lable.textAlignment = NSTextAlignmentCenter;
        UIImage *img = [self convertViewToImage:lable];
        [list addObject:img];

    }];
    NSString *str = @"未达标项： ";
    NSMutableAttributedString  *m_attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    [m_attributedString addAttribute:NSForegroundColorAttributeName
                               value:KBCOLOR_WITH_HEX(0x666666)
                               range:NSMakeRange(0, str.length)];//设
   
    
    [list enumerateObjectsUsingBlock:^(UIImage * img, NSUInteger idx, BOOL * _Nonnull stop) {
         NSTextAttachment*textAttachment = [[NSTextAttachment alloc] init];
        //给附件添加图片
        textAttachment.image= img;
        //调整一下图片的位置,如果你的图片偏上或者偏下,调整一下bounds的y值即可
        textAttachment.bounds=CGRectMake(0, -5, textAttachment.image.size.width, textAttachment.image.size.height);
        //把附件转换成可变字符串,用于替换掉源字符串中的表情文字
        NSAttributedString*imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
        [m_attributedString appendAttributedString:imageStr];
        [m_attributedString appendAttributedString:[[NSAttributedString alloc]initWithString:@" "]];//设
    }];
   
    
    
    self.itemView.subTitle.attributedText =  m_attributedString;
    
}




-(UIImage *)convertViewToImage:(UIView *)view{
    CGSize size = view.bounds.size;
    //下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (NSString *)getLableText:(NSString *)num
{
    switch ([num integerValue]) {
        case 1:
            return @"新增房源";
            break;
        case 2:
            return @"新增客源";
            break;
        case 3:
            return @"新增客源带看";
            break;
        case 4:
            return @"新增实勘作业";
            break;
            
        default:
            break;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setModel:(KBLQDetailModel * )model
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//          [self.agentView setModel:model];
//    });
  
}

- (KBLQAgentView *)agentView
{
    if (!_agentView) {
        _agentView = [[KBLQAgentView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, 100)];
    }
    return _agentView;
}


@end
