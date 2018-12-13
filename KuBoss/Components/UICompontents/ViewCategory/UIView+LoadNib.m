

#import "UIView+LoadNib.h"

@implementation UIView (LoadNib)

/**
 从xib加载一个view
 
 @param nibName xib名称
 @return 实例对象
 */
+(instancetype _Nonnull)loadViewFrom:(NSString* _Nullable)nibName{
    
    NSArray *arr =[[NSBundle mainBundle]loadNibNamed:nibName?nibName:NSStringFromClass([self class]) owner:nibName options:nil];
    for (NSObject *obj in arr) {
        if ([obj isKindOfClass:[self class]]) {
            return (UIView *)obj;
        }
    }
    return arr.lastObject;
}
@end
