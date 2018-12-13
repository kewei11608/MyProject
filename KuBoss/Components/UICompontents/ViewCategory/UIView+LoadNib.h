

#import <UIKit/UIKit.h>

@interface UIView (LoadNib)


/**
从xib加载一个view

 @param nibName xib名称
 @return 实例对象
 */
+(instancetype _Nonnull)loadViewFrom:(NSString* _Nullable)nibName;
@end
