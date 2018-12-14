//
//  ViewController.m
//  CardViewDemo
//
//  Created by chivox on 2018/12/14.
//  Copyright © 2018年 chivox. All rights reserved.
//

#import "ViewController.h"
#import "GMCardView/CardView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CardView *cardView = [[CardView alloc]initWithFrame:self.view.bounds];
    cardView.dataArr = @[@"dy",@"ca",@"nw",@"iron",@"bgf"];
    [self.view addSubview:cardView];
}

@end
