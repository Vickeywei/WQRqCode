//
//  WQReadQrCode.h
//  WQQRCode
//
//  Created by 魏琦 on 16/9/12.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
typedef void (^scanQrCodeCompletionHandle)(NSString* stringValue);
typedef void (^scanQrCodeFailureHandle)(void);
@interface WQReadQrCode : NSObject
/**
 *  扫描二维码
 *
 *  @param view 扫描视图的layer是加在这个view上的
 */
- (void)readQrCodeWithView:(UIView*)view;
@property (nonatomic, copy)scanQrCodeCompletionHandle completionHandleBlock;
@property (nonatomic, copy)scanQrCodeFailureHandle FailureHandleBlock;
@end
