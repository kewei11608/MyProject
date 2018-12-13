//
//  KBFeedBackViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/5/19.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBFeedBackViewController.h"
#import "UIView+Shadow.h"
#import "KBFeedBackViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "KBGlobalControllerCenter.h"
#import "UIViewController+BackButtonHandler.h"
#import "MBProgressHUD.h"
#import <sys/utsname.h>
#import "FeedBackDoneView.h"
#import "JFImagePickerController.h"
#import "JFImageManager.h"

@interface KBFeedBackViewController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate,FeedBackViewCellDelegate, JFImagePickerDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,copy) NSString *defaultString;
@property (nonatomic,strong) UILabel *lable;
@property (nonatomic,strong) UITextView * textView;
@property (strong, nonatomic) MBProgressHUD *HUD;
@property (nonatomic,strong)FeedBackDoneView *feedBackDoneView;
@end

@implementation KBFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"意见反馈"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.array = [[NSMutableArray alloc]init];
    KBFeedBackViewModel *model = [[KBFeedBackViewModel alloc]init];
    model.mode = KBFeedBackModeAdd;
    [self.array addObject:model];
    self.defaultString = @"请输入您的宝贵建议及意见，很感谢您的关注";
    [self setup];
    [ASSETHELPER clearData];
    // Do any additional setup after loading the view.
}

- (BOOL)navigationShouldPopOnBackButton
{
    
    [[KBGlobalControllerCenter sharedInstance] popMineMode:KBNavgationModeSetting];
    return NO;
}

 - (void)setup
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, self.view.ct_width-30, 250)];
    bgView.backgroundColor = [UIColor whiteColor];
    [bgView shadow];
    [self.view addSubview:bgView];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width-30, 210)];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [bgView addSubview: self.textView];
     self.textView.textColor = KBCOLOR_WITH_HEX(0x999999);
     self.textView.delegate =  self;
     self.textView.text =self.defaultString;
    self.textView.font = [UIFont systemFontOfSize:13];
    self.navigationController.navigationBar.translucent = NO;
    
    self.lable = [[UILabel alloc]initWithFrame:CGRectMake(bgView.ct_width-95, bgView.ct_height - 30, 80, 13)];
    self.lable.font = [UIFont systemFontOfSize:13];
    self.lable.textColor  = KBCOLOR_WITH_HEX(0x666666);
    self.lable.text = @"0/500字";
    self.lable.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:self.lable];
    
    UILabel * uplable = [[UILabel alloc]initWithFrame:CGRectMake(15, bgView.ct_bottom + 15, 200, 15)];
    uplable.font = [UIFont systemFontOfSize:13];
    uplable.textColor  = KBCOLOR_WITH_HEX(0x333333);
    uplable.text = @"上传截图（选填）";
    [self.view addSubview:uplable];
    
    //设置CollectionView的属性
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15,uplable.ct_bottom+15, self.view.ct_width-30, 165) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = YES;
    [self.view  addSubview:self.collectionView];
    //注册Cell
    [self.collectionView registerClass:[KBFeedBackViewCell class] forCellWithReuseIdentifier:@"cell"];

    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame =  CGRectMake(0,self.view.ct_height - 50-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height,self.view.ct_width, 50);
    bottomBtn.backgroundColor = kMainColor;
    [bottomBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [bottomBtn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:bottomBtn];
    [bottomBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
   
    [self.view addSubview:self.feedBackDoneView];
    [self.feedBackDoneView setAutoLayoutLeftToViewLeft:self.view constant:0];
    [self.feedBackDoneView setAutoLayoutRightToViewRight:self.view constant:0];
    [self.feedBackDoneView setAutoLayoutTopToViewTop:self.view constant:0];
    [self.feedBackDoneView setAutoLayoutBottomToViewBottom:self.view constant:0];
    
    self.feedBackDoneView.hidden  = YES;
    
    self.feedBackDoneView.backActionBlock = ^{
        [[KBGlobalControllerCenter sharedInstance] popMineMode:KBNavgationModeFeedback];
    };
    
}

- (void)hudTipWillShow:(BOOL)willShow{
    if (willShow) {
        [self resignFirstResponder];
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        if (!_HUD) {
            _HUD = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
            _HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
            _HUD.label.text = @"正在提交意见信息...";
            _HUD.removeFromSuperViewOnHide = YES;
        }else{
            _HUD.progress = 0;
            [keyWindow addSubview:_HUD];
            [_HUD showAnimated:YES];
        }
    }else{
        [_HUD hideAnimated:YES];
    }
}

- (FeedBackDoneView *)feedBackDoneView {
    if (!_feedBackDoneView) {
        _feedBackDoneView = [FeedBackDoneView loadViewFrom:@"FeedBackDoneView"];
    }
    return _feedBackDoneView;
}

- (void)submit
{
    
 
    //AFN3.0+基于封住HTPPSession的句柄
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    if ([self.textView.text  isEqualToString:self.defaultString]) {
        
         [KBAlter  show:@"请输入反馈内容" superView:self.view];
        return;
    }
    [self hudTipWillShow:YES];
    UIDevice *device = [UIDevice currentDevice];
    NSDictionary *dict = @{@"userId":[KBUserInfoModel uid],
                           @"viewsContent":self.textView.text,
//                           @"deviceInformation":[[[UIDevice currentDevice] identifierForVendor] UUIDString],
                           @"deviceInformation":[NSString stringWithFormat:@"%@, iOS %@", [self iphoneType], device.systemVersion],
                           @"version": [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]],
                           @"mobile" : [KBUserInfoModel iphone]
                           };

    [manager POST: [NSString stringWithFormat:@"%@%@/viewss/save",httpApi,httpFilePath]parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [self.array enumerateObjectsUsingBlock:^( KBFeedBackViewModel *viewModel, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx!=self.array.count-1) {
                UIImage *image = viewModel.image;
                NSData *data = UIImagePNGRepresentation(image);
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@%ld.png", str,idx];
                [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
            }
            
        }];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {

        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.HUD) {
                self.HUD.progress = uploadProgress.fractionCompleted;// progress是回调进度
            }
        });
    
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       [self hudTipWillShow:NO];
        self.feedBackDoneView.hidden = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
   
        [self hudTipWillShow:NO];
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    KBFeedBackViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.delegate = self;
    KBFeedBackViewModel *model = [self.array objectAtIndex:indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
    
}

#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(100,75);
}



#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 15, 15, 0);//（上、左、下、右）
}


#pragma mark  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
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
    
    self.lable.text = [NSString stringWithFormat:@"%ld/500字",textView.text.length];

}

- (void)pick
{
    JFImagePickerController *picker = [[JFImagePickerController alloc] initWithRootViewController:nil];
    picker.pickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    
//   UIImagePickerController * imagepicker = [[UIImagePickerController alloc]init];
//    imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    imagepicker.delegate = self;
//    [self presentViewController:imagepicker animated:YES completion:nil];
}

#pragma mark - ImagePicker Delegate

- (void)imagePickerDidFinished:(JFImagePickerController *)picker{
    [self.array removeAllObjects];
    NSArray *assetArray = picker.assets;
    [assetArray enumerateObjectsUsingBlock:^(ALAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
        KBFeedBackViewModel *model = [[KBFeedBackViewModel alloc] init];
        model.mode   = KBFeedBackModeNormal;
        model.index  = idx;
        [[JFImageManager sharedManager] thumbWithAsset:asset resultHandler:^(UIImage *result) {
            model.image = result;
        }];
        [self.array addObject:model];
    }];
    if (self.array.count < 5) {
        KBFeedBackViewModel *model = [[KBFeedBackViewModel alloc] init];
        model.mode = KBFeedBackModeAdd;
        [self.array addObject:model];
    }
    [self.collectionView reloadData];
    [self imagePickerDidCancel:picker];
}

- (void)imagePickerDidCancel:(JFImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)deleteAction:(NSInteger)index
{
    KBFeedBackViewModel *model = [self.array objectAtIndex:index];
    [self.array removeObject:model];
    __block BOOL hasAdd = NO;
    [self.array enumerateObjectsUsingBlock:^(KBFeedBackViewModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        model.index = idx;
        if (model.mode == KBFeedBackModeAdd) {
            hasAdd = YES;
        }
    }];
    if (!hasAdd) {
        KBFeedBackViewModel *model = [[KBFeedBackViewModel alloc] init];
        model.mode = KBFeedBackModeAdd;
        [self.array addObject:model];
    }
    [self.collectionView reloadData];
    
    [ASSETHELPER.selectdPhotos removeObjectAtIndex:index];
    [ASSETHELPER.selectdAssets removeObjectAtIndex:index];
}

//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//
//    //NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
//    KBFeedBackViewModel *model = [[KBFeedBackViewModel alloc]init];
//    model.mode   = KBFeedBackModeNormal;
//    model.image  = info[UIImagePickerControllerOriginalImage];
//    [self.array insertObject:model atIndex:0];
//
//    [self.array enumerateObjectsUsingBlock:^(KBFeedBackViewModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
//        model.index = idx;
//    }];
//
//    [picker dismissViewControllerAnimated:YES completion:^{
//        [self.collectionView reloadData];
//    }];
//}


- (NSString *)iphoneType {
    
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
    
}


@end
