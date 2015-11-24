//
//  HMViewController.m
//  02-pthread（演示）
//
//  Created by apple on 14-9-15.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"
#import <pthread.h>

@interface HMViewController ()

@end

@implementation HMViewController

void *run(void *data)
{
    for (int i = 0; i<10000; i++) {
        NSLog(@"touchesBegan----%d-----%@", i, [NSThread currentThread]);
    }
    return NULL;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 创建线程
    pthread_t myRestrict;
    pthread_create(&myRestrict, NULL, run, NULL);
}

@end
