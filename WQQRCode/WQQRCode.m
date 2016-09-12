//
//  WQQRCode.m
//  WQQRCode
//
//  Created by 魏琦 on 16/9/12.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import "WQQRCode.h"
#import <CoreImage/CoreImage.h>
static inline dispatch_queue_t creat_qrcodeQueue () {
    static dispatch_queue_t qr_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        qr_queue = dispatch_queue_create("qr_queue",DISPATCH_QUEUE_CONCURRENT);
    });
    return qr_queue;
}
@interface WQQRCode ()
@end
@implementation WQQRCode
+(void)qr_CodeWithString:(NSString*)dataString imageSize:(CGFloat)size qrCodeImageCompletionHandle:(void(^)(UIImage* qrCodeImage))qrCodeImageCompletionHandle {
    dispatch_async(creat_qrcodeQueue(), ^{
      UIImage* image = [self qr_CodeWithString:dataString imageSize:size];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (qrCodeImageCompletionHandle) {
                    qrCodeImageCompletionHandle(image);
                    }
            });
    });
}
+(UIImage*)qr_CodeWithString:(NSString*)dataString imageSize:(CGFloat)size{
   
    CIFilter* filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData* data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage* qr_Image = [filter outputImage];
   return [self creatNonInterpolatedUIimageFromCIImage:qr_Image withSize:size];
}

+ (UIImage*)creatNonInterpolatedUIimageFromCIImage:(CIImage*)ci_Image withSize:(CGFloat)size {
    CGRect g_extern =  CGRectIntegral(ci_Image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(g_extern), size/CGRectGetHeight(g_extern));
    size_t width = CGRectGetWidth(g_extern) * scale;
    size_t height = CGRectGetHeight(g_extern)* scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext * context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ci_Image fromRect:g_extern];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, g_extern, bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


@end
