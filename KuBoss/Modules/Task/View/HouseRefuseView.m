//
//  HouseRefuseView.m
//  KuBoss
//
//  Created by yuyang on 2018/6/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "HouseRefuseView.h"
#import "UIView+Shadow.h"
@interface HouseRefuseView()
@property (nonatomic,strong)NSString *defaultString;
@end
@implementation HouseRefuseView

- (void)awakeFromNib
{
    [super awakeFromNib];
     self.defaultString = @"请填写说明";
    [self.bgView shadow];
    self.textView.textColor = KBCOLOR_WITH_HEX(0x999999);
    self.bottomBtn.backgroundColor = kMainColor;
    
}

#pragma mark uitextviewdelegate
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
    if (text.length > 500) {
        textView.text = [textView.text substringToIndex:500];
        return;
    }
    
    self.inputTextLable.text = [NSString stringWithFormat:@"%ld/500字",textView.text.length];
    
}

- (IBAction)submit:(id)sender {
    
    if ([self.textView.text isEqualToString:self.defaultString])
    {
        [KBAlter show:@"请填写说明！" superView:self];
        return;
    }
    if (self.submitBlock) {
        self.submitBlock(self.textView.text);
    }
}



@end
