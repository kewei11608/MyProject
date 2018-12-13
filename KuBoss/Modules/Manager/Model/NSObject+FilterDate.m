//
//  NSObject+FilterDate.m
//  KuBoss
//
//  Created by yuyang on 2018/6/14.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "NSObject+FilterDate.h"

@implementation NSObject (FilterDate)
- (NSString *)getInitData
{
    NSString *date  = @"昨日数据";
    if ([KBUserDefaultLayer getLeftFilterDate]) {
        date = [self getDateModeString:[[KBUserDefaultLayer getLeftFilterDate]integerValue]+1] ;
    }
    NSString *value = [NSString stringWithFormat:@"昨日 %@",[self getPreDay:-1]];
    if ([KBUserDefaultLayer getVauleFilterDate]) {
        value = [KBUserDefaultLayer getVauleFilterDate];
    }
    
    return  [NSString stringWithFormat:@"%@ %@",value,date];
    
}

- (NSString *)getDateModeString:(NSInteger) index
{
    switch (index) {
        case KBDateModeDay:
            return @"昨日数据";
            break;
        case KBDateModeWeek:
            return @"周数据";
            break;
        case KBDateModeMonth:
            return @"月数据";
            break;
            
        default:
            break;
    }
    return @"昨日数据";
}

- (NSString *)getPreDay:(NSInteger )index
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM.dd"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    //    [lastMonthComps setYear:1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    [lastMonthComps setDay:index];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
    return [formatter stringFromDate:newdate];
}

- (NSMutableAttributedString *)setTitleName:(NSString *)imageName  string:(NSString *)string
{
    NSMutableAttributedString  *m_attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    [m_attributedString addAttribute:NSForegroundColorAttributeName
                               value:KBCOLOR_WITH_HEX(0x666666)
                               range:NSMakeRange(0, string.length)];//设
    NSTextAttachment*textAttachment = [[NSTextAttachment alloc] init];
    //给附件添加图片
    textAttachment.image= [UIImage imageNamed:imageName];
    //调整一下图片的位置,如果你的图片偏上或者偏下,调整一下bounds的y值即可
    textAttachment.bounds=CGRectMake(0, -2, textAttachment.image.size.width, textAttachment.image.size.height);
    //把附件转换成可变字符串,用于替换掉源字符串中的表情文字
    NSAttributedString*imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [m_attributedString appendAttributedString:imageStr];
    
    return m_attributedString;
}

- (NSString *)getMonth:(NSInteger )index  format:(NSString *)format
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    //    [lastMonthComps setYear:1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    [lastMonthComps setMonth:index];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
    return [formatter stringFromDate:newdate];
}

- (NSMutableAttributedString *)getArrow:(NSString *)text
{
    NSMutableAttributedString  *m_attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@   ",text]];
    
    [m_attributedString addAttribute:NSForegroundColorAttributeName
                               value:kMainColor
                               range:NSMakeRange(0, text.length)];//设
    NSTextAttachment*textAttachment = [[NSTextAttachment alloc] init];
    //给附件添加图片
    textAttachment.image= [UIImage imageNamed:@"right_arrow"];
    //调整一下图片的位置,如果你的图片偏上或者偏下,调整一下bounds的y值即可
    textAttachment.bounds=CGRectMake(0, -3,8, 15);
    //把附件转换成可变字符串,用于替换掉源字符串中的表情文字
    NSAttributedString*imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [m_attributedString appendAttributedString:imageStr];
    return  m_attributedString;
}

@end
