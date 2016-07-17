//
//  ViewController.m
//  NSOperation
//
//  Created by asus on 16/7/17.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()



- (IBAction)dependentBtnDidClick:(id)sender;

- (IBAction)groupBtnDidClick:(id)sender;

- (IBAction)asyncBtnDidClick:(id)sender;




@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSOperation *operation1;
@property (nonatomic, strong) NSOperation *operation2;

@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}


- (IBAction)dependentBtnDidClick:(id)sender {
    
    self.operation1 = [NSBlockOperation blockOperationWithBlock:^{
        FDLog(@"operation1Function, 线程--%@", [NSThread currentThread]);
    }];
    
    self.operation1.completionBlock = ^{
        FDLog(@"操作1 完成,线程--%@", [NSThread currentThread]);
    };
    
    self.operation2 = [NSBlockOperation blockOperationWithBlock:^{
        FDLog(@"operation2Function, 线程--%@", [NSThread currentThread]);
    }];
    self.operation2.completionBlock = ^{
        FDLog(@"操作2 完成,线程--%@", [NSThread currentThread]);
    };
    
    [self.operation2 addDependency:self.operation1];
    [self.queue addOperation:self.operation2];
    [self.queue addOperation:self.operation1];
    
    
    
}

- (IBAction)groupBtnDidClick:(id)sender {
    
    
    self.operation1 = [NSBlockOperation blockOperationWithBlock:^{
        FDLog(@"operation1Function, 线程--%@", [NSThread currentThread]);
    }];
    
    self.operation1.completionBlock = ^{
        FDLog(@"操作1 完成,线程--%@", [NSThread currentThread]);
    };
    
    [self.queue addOperation:self.operation1];
}

- (IBAction)asyncBtnDidClick:(id)sender {
    
    self.operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation1Function) object:nil];
    self.operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation2Function) object:nil];
    
    [self.queue addOperation:self.operation1];
    [self.queue addOperation:self.operation2];  //添加了两个操作，自动会是异步多线程执行，如果只有一个操作，默认就是在当前线程串行执行
}

- (void)operation1Function
{
    
    FDLog(@"operation1Function, 线程--%@", [NSThread currentThread]);
}

- (void)operation2Function
{
    FDLog(@"operation2Function, 线程--%@", [NSThread currentThread]);
}


- (NSOperationQueue *)queue
{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 3; //最大并发数
    }
    
    return _queue;
}
@end
