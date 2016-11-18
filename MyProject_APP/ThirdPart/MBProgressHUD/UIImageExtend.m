
#import "UIImageExtend.h"

@implementation UIImage(extend)


+ (UIImage *)fixOrientation:(UIImage*)image {
    
    // No-op if the orientation is already correct
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


+(NSString*)mainResourceBundlePath:(NSString*)imagepath{
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:imagepath];
}

/**
 @功能:直接从打包的Bundle中读取图片，不会缓存
 @参数:NSString   图片名称
 @返回值:图片对象
 */
+ (UIImage *)getImageFromMyBundleWithName:(NSString *)imageName
{
    return [self getImageFromBundleWithName:RESOURCEBUNDLENAME imageName:imageName];
}

+ (UIImage *)getImageFromBundleWithName:(NSString*)bundlepath imageName:(NSString *)imageName
{
    NSMutableString * name = [[NSMutableString alloc] initWithString:imageName];
    NSRange range = [name rangeOfString:@"."];
    if (range.location == NSNotFound) {
        [name appendString:@".png"];
    }
    NSString * main_images_dir_path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle", bundlepath]];
    NSString * image_path = [main_images_dir_path stringByAppendingPathComponent:name];
    //NSLog(@"%@", image_path);
    
    UIImage* retimage = [UIImage imageWithContentsOfFile:image_path];
    
    if (retimage==nil && ![[NSFileManager defaultManager] fileExistsAtPath:image_path]) {
        NSLog(@"%@", image_path);
        NSLog(@"缺少资源文件，将会引起系统异常，请马上和开发人员联系");
    }
    
    return retimage;
}

+(NSBundle *)getResourceBundleWith:(NSString*)bundlepath{
    NSString * bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle",bundlepath]];
    NSBundle * bundle = [NSBundle bundleWithPath:bundlePath];
    
    return bundle;
}

+(NSBundle *)getResourceBundle{
    return [self getResourceBundleWith:RESOURCEBUNDLENAME];
}

/**
 @功能:直接从NSBundle中读取图片，不会缓存
 @参数:NSString   图片名称，必须代后缀名
 @返回值:图片对象
 */
+(UIImage*) imagePathed:(NSString*)imageName
{
    //获取文件名
    NSString *realName = [imageName stringByDeletingPathExtension];
    //获取后缀名
    NSString *extention = [imageName pathExtension];
    //获取文件路径
    NSString *imagePath = nil;
    UIImage *returnImage = nil;
    
    /* 当有命名规则时使用
     //判断是否为iphone
     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
     {
     //[UIScreen mainScreen].scale普通屏为1.0，高清为2.0
     //iphone5
     if (([UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale) >=1136)
     {
     realName = [realName stringByAppendingFormat:@"-568h@2x"];
     }
     }
     */
    
    imagePath = [[NSBundle mainBundle]pathForResource:realName ofType:extention];
    returnImage = [UIImage imageWithContentsOfFile:imagePath];
    //取不到,尝试以缓存形式取
    if (!returnImage) {
        returnImage = [UIImage imageNamed:realName];
//        NSLog(@"by imageNamed");
    }
    return returnImage;
}

/**
 @功能:缩放图片到指定大小
 @参数1:CGSize   缩放后的大小
 @返回值:更改后的图片对象
 */
-(UIImage*)imageByScalingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
        {
            scaleFactor = widthFactor; // scale to fit height
        }
        else
        {
            scaleFactor = heightFactor; // scale to fit width
        }
        
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if ( scaledImage == nil )
    {
        NSLog(@"UIImageRetinal:could not scale image!!!");
        return nil;
    }
    
    UIGraphicsEndImageContext();
    return scaledImage;
}

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
-(UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize percent:(float)percent
{
    UIImage *scaledImage = [self imageByScalingForSize:targetSize];
    
    if (scaledImage == nil)
    {
        NSLog(@"UIImageRetinal:could not scale and crop image!!!");
        return nil;
    }
    
    NSData *thumbImageData = UIImageJPEGRepresentation(scaledImage, percent);
    UIImage *newImage = [UIImage imageWithData:thumbImageData];
    return newImage;
}

//压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}
/**
 @功能:使用特定的颜色替换当前图片（透明部分不会被替换）
 @参数1:UIImage   目标图片
 @参数2:UIColor   要替换的颜色
 @返回值:更改后的图片对象
 */
+(UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor {
    
    UIGraphicsBeginImageContext(baseImage.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, baseImage.size.width, baseImage.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, baseImage.CGImage);
    
    [theColor set];
    CGContextFillRect(ctx, area);
	
    CGContextRestoreGState(ctx);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextDrawImage(ctx, area, baseImage.CGImage);
	
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 @功能:蒙版功能
 @参数1:UIImage   目标图片
 @参数2:UIImage   蒙版图片
 @返回值:更改后的图片对象
 */
+(UIImage *)maskImage:(UIImage *)baseImage withImage:(UIImage *)theMaskImage
{
	UIGraphicsBeginImageContext(baseImage.size);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGRect area = CGRectMake(0, 0, baseImage.size.width, baseImage.size.height);
	CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
	
	CGImageRef maskRef = theMaskImage.CGImage;
	
	CGImageRef maskImage = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                             CGImageGetHeight(maskRef),
                                             CGImageGetBitsPerComponent(maskRef),
                                             CGImageGetBitsPerPixel(maskRef),
                                             CGImageGetBytesPerRow(maskRef),
                                             CGImageGetDataProvider(maskRef), NULL, false);
	
	CGImageRef masked = CGImageCreateWithMask([baseImage CGImage], maskImage);
	CGImageRelease(maskImage);
	
	CGContextDrawImage(ctx, area, masked);
	CGImageRelease(masked);
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
	
	return newImage;
}

// 画水印
- (UIImage *) imageWithWaterMask:(UIImage*)mask inRect:(CGRect)rect
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0)
    {
        UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0); // 0.0 for scale means "scale for device's main screen".
    }
#else
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 4.0)
    {
        UIGraphicsBeginImageContext([self size]);
    }
#endif
    
    //原图
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //水印图
    [mask drawInRect:rect];
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newPic;
}

- (UIImage *) imageWithStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0)
    {
        UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0); // 0.0 for scale means "scale for device's main screen".
    }
#else
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 4.0)
    {
        UIGraphicsBeginImageContext([self size]);
    }
#endif
    
    //原图
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    //文字颜色
    [color set];
    
    //水印文字
    [markString drawInRect:rect withFont:font];
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newPic;
}

- (UIImage *) imageWithStringWaterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0)
    {
        UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0); // 0.0 for scale means "scale for device's main screen".
    }
#else
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 4.0)
    {
        UIGraphicsBeginImageContext([self size]);
    }
#endif
    
    //原图
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    CGSize stringSize = [markString sizeWithFont:font constrainedToSize:self.size lineBreakMode:NSLineBreakByCharWrapping];
    
    //文字颜色
    [color set];
    //水印文字
    if (stringSize.width <= self.size.width && stringSize.height <= self.size.height) {
        [markString drawAtPoint:CGPointMake((self.size.width - stringSize.width) / 2, (self.size.height - stringSize.height) / 2) withFont:font];
    }else{
        [markString drawAtPoint:point withFont:font];
    }
    
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newPic;
}

- (BOOL) writeImageToFileAtPath:(NSString*)aPath
{
    if ((aPath == nil) || ([aPath isEqualToString:@""]))
    {
        return NO;
    }
    
    @try
    {
        NSData *imageData = nil;
        NSString *ext = [aPath pathExtension];
        if ([ext isEqualToString:@"png"])
        {
            imageData = UIImagePNGRepresentation(self);
        }
        else
        {
            // the rest, we write to jpeg
            // 0. best, 1. lost. about compress.
            imageData = UIImageJPEGRepresentation(self, 0);
        }
        
        if ((imageData == nil) || ([imageData length] <= 0))
        {
            return NO;
        }
        
        [imageData writeToFile:aPath atomically:YES];
        
        return YES;
    }
    @catch (NSException *e)
    {
        NSLog(@"create thumbnail exception.");
    }
    
    return NO;
}
//uicolor转uiimage
+ (UIImage *) createImageWithColor: (UIColor *) color andSize:(CGSize)size
{
    CGRect rect=CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *) createImageWithColor: (UIColor *) color1 size1:(CGSize)size1 color2:(UIColor *) color2 size2:(CGSize)size2
{
    CGRect rect=CGRectMake(0, 0, size1.width, size1.height + size2.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color1 CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size1.width, size1.height));
    
    CGContextSetFillColorWithColor(context, [color2 CGColor]);
    CGContextFillRect(context, CGRectMake(0, size1.height, size2.width, size2.height));
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
