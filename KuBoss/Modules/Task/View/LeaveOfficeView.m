//
//  LeaveOfficeView.m
//  KuBoss
//
//  Created by yuyang on 2018/5/27.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "LeaveOfficeView.h"
#import "UIView+Shadow.h"

@interface LeaveOfficeView ()
@property (nonatomic,strong)NSString *defaultString;

@end

@implementation LeaveOfficeView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.bgView shadow];
    self.defaultString = @"请您填写该员工的离职原因";
    [self.bgView shadow];
    self.textView.textColor = KBCOLOR_WITH_HEX(0x999999);
    self.dateBtn.layer.cornerRadius = 5;
    self.dateBtn.layer.masksToBounds = YES;
    self.dateBtn.layer.borderWidth = 0.5;
    self.dateBtn.layer.borderColor = KBCOLOR_WITH_HEX(0x979797).CGColor;
    NSDate *date=[NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"   yyyy.MM.dd"];
    [self.dateBtn setTitle:[format1 stringFromDate:date]forState:UIControlStateNormal];
    [self.dateBtn setTitleColor:KBCOLOR_WITH_HEX(0x666666) forState:UIControlStateNormal];
    self.textView.text = self.defaultString;
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.textColor = [UIColor blackColor];
    if ([textView.text  isEqualToString:self.defaultString]) {
        textView.text = @"";
    }
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        textView.textColor = KBCOLOR_WITH_HEX(0x999999);
        textView.text = self.defaultString;
    }
    
}

- (void)textViewDidChange:(UITextView *)textView

{
    NSString *text = textView.text;
    if (text.length > 100) {
        textView.text = [textView.text substringToIndex:100];
        return;
    }
    
    self.inputTextLable.text = [NSString stringWithFormat:@"%ld/100字",textView.text.length];
    
}

- (IBAction)dateAction:(id)sender {
    
    if (self.dateBlock) {
        self.dateBlock();
    }
}

- (IBAction)sumbit:(id)sender {
    if ([self.textView.text isEqualToString:self.defaultString])
    {
        [KBAlter show:@"请填写离职原因！" superView:self];
        return;
    }
    if (self.submitBlock) {
        self.submitBlock(self.textView.text);
    }
}



@end
