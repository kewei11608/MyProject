//
//Created by ESJsonFormatForMac on 18/05/21.
//

#import <Foundation/Foundation.h>

@class  KBLQRecordData, KBLQRecordShop, KBLQRecordAgent;
@interface  KBLQRecordModel : KBBaseModel

@property (nonatomic, strong)  KBLQRecordData *data;


@end
@interface  KBLQRecordData : NSObject

@property (nonatomic, strong) NSArray< KBLQRecordShop *> *symddlhxxtj;

@end

@interface  KBLQRecordShop : NSObject

@property (nonatomic, strong) NSArray< KBLQRecordAgent *> *jjrlist;

@property (nonatomic, copy) NSString *officename;

@property (nonatomic, copy) NSString *officeid;

@property (nonatomic, assign) BOOL  isOpen;

@end

@interface  KBLQRecordAgent : NSObject

@property (nonatomic, copy) NSString *jjmc;

@property (nonatomic, assign) NSInteger sflx;

@property (nonatomic, assign) NSInteger sysl;

@property (nonatomic, assign) NSInteger ysl;

@property (nonatomic, assign) NSInteger zsl;

@property (nonatomic, assign) NSInteger agentid;

@property (nonatomic, copy) NSString *jjtx;



@end

