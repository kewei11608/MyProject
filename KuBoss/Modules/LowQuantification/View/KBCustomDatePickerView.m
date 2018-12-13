//
//  KBCustomDatePickerView.m
//  Demo
//
//  Created by yuyang on 2018/5/21.
//  Copyright © 2018年 shareit. All rights reserved.
//

#import "KBCustomDatePickerView.h"
@interface KBCustomDatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) NSMutableArray *dateArray;
@property (nonatomic,copy) NSString  *hour;
@property (nonatomic,copy) NSString  *min;
@end

@implementation KBCustomDatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self setup];
    return self;
}

- (void)setup
{
    self.hour = @"00";
    self.min = @"00";
    self.dateArray = [[NSMutableArray alloc]init];
    
    NSMutableArray *hourArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i<25; i++) {
        if (i<10) {
             [hourArray addObject: [NSString stringWithFormat:@"0%ld",i]];
        }
        else
        {
             [hourArray addObject: [NSString stringWithFormat:@"%ld",i]];
        }
      
    }
    [self.dateArray addObject:hourArray];
    
    NSMutableArray *minArray = [[NSMutableArray alloc]init];
    NSInteger min = 0;
    for (NSInteger i = 0; i<13; i++) {
        if (min<10) {
            [minArray addObject: [NSString stringWithFormat:@"0%ld",min]];
        }
        else
        {
            [minArray addObject: [NSString stringWithFormat:@"%ld",min]];
        }
        min += 5;
    }
    [self.dateArray addObject:minArray];
    
    
    UIPickerView *pickView = [[UIPickerView alloc]initWithFrame:self.bounds];
    pickView.backgroundColor = [UIColor whiteColor];
    pickView.delegate = self;
    pickView.dataSource = self;
    [self  addSubview:pickView];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView {
    return self.dateArray.count;
}

-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component {
    return  ((NSArray *)[self.dateArray objectAtIndex:component]).count;
}

-(NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = [(NSArray *)[self.dateArray objectAtIndex:component] objectAtIndex:row];
    
    if (component == 0)
    {
        title = [NSString stringWithFormat:@"%@ 时",title];
    }
    else if (component == 1)
    {
        title = [NSString stringWithFormat:@"%@ 分",title];
    }
    
    return title;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0)
    {
        self.hour = [(NSArray *)[self.dateArray objectAtIndex:component] objectAtIndex:row];
    }else if (component == 1)
    {
        self.min = [(NSArray *)[self.dateArray objectAtIndex:component] objectAtIndex:row];
    }
    
    if (self.pickViewBlock) {
        self.pickViewBlock(self.hour, self.min);
    }
}



@end
