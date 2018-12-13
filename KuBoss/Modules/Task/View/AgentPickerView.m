//
//  AgentPickerView.m
//  KuBoss
//
//  Created by yuyang on 2018/6/10.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "AgentPickerView.h"
@interface AgentPickerView ()
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,copy)   NSString *currentSelectedId;
@property (nonatomic,copy)   NSString *agentName;
@property (nonatomic,copy)   NSString *shopName;
@property (nonatomic,assign)  NSInteger  officeShopIndex;
@property (nonatomic,assign)  BOOL  isFirst;
@end
@implementation AgentPickerView
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.list = [[NSMutableArray alloc] init];
    self.officeShopIndex = 0;
}

- (void)setArray:(NSMutableArray *)array
{
    [self.list removeAllObjects];
    [self.list addObjectsFromArray:array];
    [self.picker reloadAllComponents];
    
    if (!self.isFirst) {
        if (self.list.count >0) {
            KBRoomAgentList *model = [self.list objectAtIndex:0];
            self.shopName = model.officename;
            if (model.officeagentlist>0) {
                KBRoomAgent *m = [model.officeagentlist objectAtIndex:0];
                self.agentName = m.agentname;
            }
        }
        self.isFirst = YES;
    }

}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView {
    return 2;
}

-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0)
    {
        return self.list.count;
    }
    else  if (component == 1)
    {
        if (self.officeShopIndex <self.list.count ) {
            KBRoomAgentList *model = [self.list objectAtIndex:self.officeShopIndex];
            return model.officeagentlist.count;
        }
        return 0;
       
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel){
        
        pickerLabel = [[UILabel alloc] init];
        
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        
        [pickerLabel setFont:[UIFont systemFontOfSize:16]];
        
    }
    
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
    
}

-(NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  

    if (component == 0)
    {
         if (self.officeShopIndex <self.list.count )
         {
              KBRoomAgentList *model = [self.list objectAtIndex:self.officeShopIndex];
            
              return  model.officename;
         }
        return nil;
        
    }
    else if (component == 1)
    {
        if (self.officeShopIndex <self.list.count )
        {
            KBRoomAgentList *model = [self.list objectAtIndex:self.officeShopIndex];
            KBRoomAgent *m = [model.officeagentlist objectAtIndex:row];
            return  m.agentname;
        }
        return nil;
    
    }
    
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
 
    if (component == 0)
    {
        self.officeShopIndex = component;
        KBRoomAgentList *model = [self.list objectAtIndex:self.officeShopIndex];
        self.shopName  = model.officename;
        [self.picker reloadAllComponents];
       
    }
    else if (component == 1)
    {
        
        KBRoomAgentList *model = [self.list objectAtIndex:self.officeShopIndex];
        KBRoomAgent *m = [model.officeagentlist objectAtIndex:row];
        self.currentSelectedId = m.accountid;
        self.agentName = m.agentname;

    }
    
  

}
- (IBAction)cancelAction:(id)sender {
    self.hidden = YES;
}
- (IBAction)sureAction:(id)sender {
    if (self.didPickerBlock) {
        self.didPickerBlock(self.shopName,self.agentName,self.currentSelectedId);
    }
    self.hidden = YES;
}


@end
