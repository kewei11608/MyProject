//
//  KBLQItemView.m
//  KuBoss
//
//  Created by yuyang on 2018/5/24.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "ItemView.h"
#import "UIView+Shadow.h"
@interface ItemView ()
@property (weak, nonatomic) IBOutlet UIView *line111;


@end
@implementation ItemView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.bg.backgroundColor = [UIColor whiteColor];
    [self.bg shadow];
    self.bottomView.backgroundColor = KBCOLOR_WITH_HEX(0xE8E8E8);
    self.tip.textColor = KBCOLOR_WITH_HEX(0x666666);
    self.line111.backgroundColor= KBCOLOR_WITH_HEX(0xEFEFEF);
    self.bottomView.enabled = NO;
    
}

- (IBAction)reminderAction:(id)sender {
    if (self.reminderActionBlcok) {
        self.reminderActionBlcok();
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

@end
