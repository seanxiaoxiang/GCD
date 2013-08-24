//
//  MyViewController.m
//  GCD
//
//  Created by welseyxiao on 13-8-23.
//  Copyright (c) 2013年 welseyxiao. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    int (^oneFrom)(int,float);
    
    oneFrom = ^(int anInt,float f1) {
        return anInt - 1;
    };
    
    //declare a block
    int (^aBlock)(int , int, float);

    //create a block
    aBlock = ^(int i21,int i22,float f21){
        return 1;
    };
    
    aBlock(1,1,1);
    
    
    dispatch_group_t       group = dispatch_group_create();
    dispatch_semaphore_t   semaphore = dispatch_semaphore_create(10);
    dispatch_queue_t       queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
   
    
    
    for (int i = 0; i < 100; i++) {
        //等待信号量
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
           
            sleep(1);
            NSLog(@"processing queue1 id:%d currentQueue:%@",i,dispatch_get_current_queue());

            sleep(1);
            
            //释放信号量 
            dispatch_semaphore_signal(semaphore);
        });
        
        
       

    }
    
  
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_release(group);
    dispatch_release(semaphore);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
