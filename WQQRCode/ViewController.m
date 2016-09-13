//
//  ViewController.m
//  WQQRCode
//
//  Created by 魏琦 on 16/9/12.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import "ViewController.h"
#import "WQQRCode.h"
#import "WQReadQrCode.h"
@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong)WQReadQrCode* readCode;
@property (nonatomic, strong,readwrite)AVCaptureSession* session;
@property (nonatomic, strong,readwrite) AVCaptureVideoPreviewLayer* layer;
@end

@implementation ViewController
- (IBAction)scan:(id)sender {
    self.readCode = [[WQReadQrCode alloc] init];
    self.readCode.completionHandleBlock = ^ (NSString* stringValue){
        NSLog(@"%@",stringValue);
        if ([stringValue containsString:@"com"] | [stringValue containsString:@"https"]) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:stringValue]];
        }
    };
    [_readCode readQrCodeWithView:self.imageView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* dataString = @"345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765345677654345678987545678987654567898765456789876545678765";
    [WQQRCode qr_CodeWithString:dataString imageSize:self.imageView.frame.size.width qrCodeImageCompletionHandle:^(UIImage *qrCodeImage) {
         self.imageView.image = qrCodeImage;
    }];
    
   
    
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
