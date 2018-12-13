//
//  RoomDetailHandleView.m
//  KuBoss
//
//  Created by yuyang on 2018/6/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "RoomDetailHandleView.h"
@interface RoomDetailHandleView ()
@property (nonatomic,strong)NSString *defaultString;
@end
@implementation RoomDetailHandleView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.defaultString = @"请填写说明";
    [self.bgView shadow];
    self.inputTextView.textColor = KBCOLOR_WITH_HEX(0x999999);
    [self setCustomLayer:self.sourceBtn];
    [self setCustomLayer:self.rentUnitBtn];
    [self setCustomLayer:self.RentTypeBtn];
    [self setCustomLayer:self.btnSeller];
    [self setCustomLayer:self.btnRenter];

    
}

- (void)setCustomLayer:(UIView *)view
{
    view.layer.cornerRadius = 4;
    view.layer.masksToBounds = YES;
    view.layer.borderColor =KBCOLOR_WITH_HEX(0xEBEBEB).CGColor;
    view.layer.borderWidth = 0.5;
}

- (IBAction)sourceAction:(id)sender {
    if(self.sourceBlock){
        self.sourceBlock();
    }
}
- (IBAction)renterAction:(id)sender {
    if (self.renterBlock) {
        self.renterBlock();
    }
}

- (IBAction)sellerAction:(id)sender {
    if (self.sellerBlock) {
        self.sellerBlock();
    }
}


- (IBAction)rentUnitAction:(id)sender {
    if(self.rentUnitBlock){
        self.rentUnitBlock();
    }
    
}
- (IBAction)rentTypeAction:(id)sender {
    if(self.rentTypeBlock){
        self.rentTypeBlock();
    }
}

- (IBAction)agreeAction:(id)sender {
    
    if ([self.inputTextView.text isEqualToString:self.defaultString])
    {
        [KBAlter show:@"请填写说明！" superView:self];
        return;
    }
    if (self.agreeBlock) {
        self.agreeBlock();
    }
    
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
    
    self.textInputLable.text = [NSString stringWithFormat:@"%ld/500字",textView.text.length];
    
}
@end
