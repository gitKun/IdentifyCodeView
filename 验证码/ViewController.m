//
//  ViewController.m
//  验证码
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 CaiFu. All rights reserved.
//

#import "ViewController.h"
#import "DRIdentifyCodeView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet DRIdentifyCodeView *codeLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.codeLabel.bJustNumber = YES;
    self.codeLabel.nLength = 4;
//    self.codeLabel.clBackground = [UIColor colorWithRed:214/255.0 green:10/255.0 blue:220/255.0 alpha:1];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tztRefresh)];
    [self.codeLabel addGestureRecognizer:tap];
   // printTest();
    
    //[self testCase];
}

- (void)testCase {
    dispatch_queue_t serialQueue = dispatch_queue_create("aaa", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_async(serialQueue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"2");
        dispatch_sync(serialQueue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"6");
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"7");
        });
        NSLog(@"8");
    });
    
    NSLog(@"9");
    
    while (1) {
        
    }
}

void printTest(void) {
    int a[5] = {1,2,3,4,5};
    
    int *ptr = (int *)(&a+1);
    
    printf("%d,%d",*(a+1),*(ptr-1));
    
}

- (void)tztRefresh {
    [self.codeLabel DRRefresh];
    self.textLabel.text = self.codeLabel.code;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
