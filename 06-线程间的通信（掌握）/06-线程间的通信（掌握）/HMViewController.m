//
//  HMViewController.m
//  06-线程间的通信（掌握）
//
//  Created by apple on 14-9-15.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"

@interface HMViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self performSelectorInBackground:@selector(download) withObject:nil];
}

/**
 *  下载图片
 */
- (void)download
{
    NSLog(@"download---%@", [NSThread currentThread]);
    // 1.图片地址
    NSString *urlStr = @"http://d.hiphotos.baidu.com/image/pic/item/37d3d539b6003af3290eaf5d362ac65c1038b652.jpg";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2.根据地址下载图片的二进制数据(这句代码最耗时)
    NSLog(@"---begin");
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSLog(@"---end");
    
    // 3.设置图片
    UIImage *image = [UIImage imageWithData:data];
    
    // 4.回到主线程，刷新UI界面(为了线程安全)
//    [self performSelectorOnMainThread:@selector(downloadFinished:) withObject:image waitUntilDone:NO];
    [self performSelector:@selector(downloadFinished:) onThread:[NSThread mainThread] withObject:image waitUntilDone:YES];
//    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
    
    NSLog(@"-----done----");
}

- (void)downloadFinished:(UIImage *)image
{
    self.imageView.image = image;
    
    NSLog(@"downloadFinished---%@", [NSThread currentThread]);
}

@end
