//
//  WUBaseViewController.m
//  SmallDay
//
//  Created by wuqh on 15/10/12.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUBaseViewController.h"

@interface WUBaseViewController ()

@end

@implementation WUBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationItem.leftBarButtonItem =
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
