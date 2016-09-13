//
//  WQReadQrCode.m
//  WQQRCode
//
//  Created by 魏琦 on 16/9/12.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import "WQReadQrCode.h"
static inline dispatch_queue_t creat_ReadQrCodeQueue () {
    static dispatch_queue_t qr_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        qr_queue = dispatch_queue_create("read_qrCodeQueue",DISPATCH_QUEUE_SERIAL);
    });
    return qr_queue;
}
@interface WQReadQrCode () <AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong,readwrite)AVCaptureSession* session;
@property (nonatomic, strong,readwrite) AVCaptureVideoPreviewLayer* layer;
@end
@implementation WQReadQrCode
- (void)readQrCodeWithView:(UIView*)view{

    AVCaptureSession* session = [[AVCaptureSession alloc] init];
    self.session = session;
    AVCaptureDevice* device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError* error;
    
    AVCaptureDeviceInput* input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (!input) {
        [NSException raise:@"AVCaptureDeviceInputException"  format:@"AV Capture device input does not exist or is the device does not support the input",nil];
    }
    [session addInput:input];
    AVCaptureMetadataOutput* output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:(id)self queue:creat_ReadQrCodeQueue()];
    [session addOutput:output];
    [output setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    AVCaptureVideoPreviewLayer* layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    [layer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    layer.frame = view.layer.bounds;
    [view.layer addSublayer:layer];
    self.layer = layer;
    [session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject* object = [metadataObjects lastObject];
        [self.session stopRunning];
        [self.layer removeFromSuperlayer];
        if (self.completionHandleBlock) {
            self.completionHandleBlock(object.stringValue);
        }
    }
    else {
        if (self.FailureHandleBlock) {
            self.FailureHandleBlock();
        }
    }
}


@end
