
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIImage(extend)

#define RESOURCEBUNDLENAME @"CoreLibResource"

+ (UIImage *)fixOrientation:(UIImage*)image;

/**
 @功能:直接从打包的Bundle中读取图片，不会缓存
 @参数:NSString   图片名称
 @返回值:图片对象
 */
+ (UIImage *)getImageFromMyBundleWithName:(NSString *)imageName;
+ (UIImage *)getImageFromBundleWithName:(NSString*)bundlepath imageName:(NSString *)imageName;
+(NSBundle *)getResourceBundle;
+(NSBundle *)getResourceBundleWith:(NSString*)bundlepath;
+(NSString*)mainResourceBundlePath:(NSString*)imagepath;

/**
 @功能:直接从NSBundle中读取图片，不会缓存
 @参数:NSString   图片名称，必须代后缀名
 @返回值:图片对象
 */
+(UIImage*)imagePathed:(NSString*)imageName;

/**
 @功能:使用特定的颜色替换当前图片（透明部分不会被替换）
 @参数1:UIImage   目标图片
 @参数2:UIColor   要替换的颜色
 @返回值:更改后的图片对象
 */
+(UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor;


/**
 @功能:蒙版功能
 @参数1:UIImage   目标图片
 @参数2:UIImage   蒙版图片
 @返回值:更改后的图片对象
 */
+(UIImage *)maskImage:(UIImage *)baseImage withImage:(UIImage *)theMaskImage;

/**
 @功能:缩放图片到指定大小
 @参数1:CGSize   缩放后的大小
 @返回值:更改后的图片对象
 */
-(UIImage*)imageByScalingForSize:(CGSize)targetSize;


/**
 @功能:缩放图片到指定大小，并压缩图片
 @参数1:CGSize    缩放后的大小
 @参数2:float     压缩值，百分比(0.0f-1.0f)，随着百分比的增加，压缩出来的图片大小也随之增加
 @返回值:更改后的图片对象
 */

/**
 * @reqno:H1604050028
 * @date-designer:20160407-mobei
 * @date-author:20160407-mobei: 缩放图片到指定大小，并压缩图片。
 */

-(UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize percent:(float)percent;

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

// 保存图像文件
- (BOOL) writeImageToFileAtPath:(NSString*)aPath;
// 图片水印
- (UIImage *) imageWithWaterMask:(UIImage*)mask inRect:(CGRect)rect;
// 文字水印
- (UIImage *) imageWithStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font;
- (UIImage *) imageWithStringWaterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font;
//uicolor转uiimage
+ (UIImage *) createImageWithColor: (UIColor *) color andSize:(CGSize)size;
+ (UIImage *) createImageWithColor: (UIColor *) color1 size1:(CGSize)size1 color2:(UIColor *) color2 size2:(CGSize)size2;

@end