//
//  RoomDetailHandleView.h
//  KuBoss
//
//  Created by yuyang on 2018/6/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^agreeBlock_t)(void);

typedef void (^sourceBlock_t)(void);

typedef void (^rentTypeBlock_t)(void);

typedef void (^rentUnitBlock_t)(void);

typedef void (^renterBlock_t)(void);

typedef void (^sellerBlock_t)(void);




@interface RoomDetailHandleView : UIView
@property (weak, nonatomic) IBOutlet UILabel *houseCode;
@property (weak, nonatomic) IBOutlet UILabel *propertyName;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *propertyType;
@property (weak, nonatomic) IBOutlet UILabel *houseType;
@property (weak, nonatomic) IBOutlet UILabel *area;
@property (weak, nonatomic) IBOutlet UILabel *orientations;
@property (weak, nonatomic) IBOutlet UILabel *architecturalType;
@property (weak, nonatomic) IBOutlet UILabel *houseYear;
@property (weak, nonatomic) IBOutlet UILabel *statusLable;
@property (weak, nonatomic) IBOutlet UIButton *sourceBtn;

@property (weak, nonatomic) IBOutlet UIButton *rentUnitBtn;

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet UILabel *textInputLable;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *RentTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *btnRenter;

@property (weak, nonatomic) IBOutlet UIButton *btnSeller;

@property (weak, nonatomic) IBOutlet UITextField *textFieldRentPrice;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSellPrice;




@property (nonatomic,copy) agreeBlock_t agreeBlock;

@property (nonatomic,copy) sourceBlock_t sourceBlock;

@property (nonatomic,copy) rentTypeBlock_t rentTypeBlock;

@property (nonatomic,copy) rentUnitBlock_t rentUnitBlock;

@property (nonatomic,copy) renterBlock_t renterBlock;

@property (nonatomic,copy) sellerBlock_t sellerBlock;

@end
