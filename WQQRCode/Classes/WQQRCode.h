//
//  WQQRCode.h
//  WQQRCode
//
//  Created by 魏琦 on 16/9/12.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface WQQRCode : NSObject
/**
 *  @author vicky
 *
 *  @param dataString                  二维码内容(纯文本,名片,URL)
 *  @param size                        生成二维码图片的宽度
 *  @param qrCodeImageCompletionHandle 生成二维码后的回调
 */
+(void)qr_CodeWithString:(NSString*)dataString imageSize:(CGFloat)size qrCodeImageCompletionHandle:(void(^)(UIImage* qrCodeImage))qrCodeImageCompletionHandle;
@end
