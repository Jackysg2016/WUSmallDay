//
//  WUTabBarController.m
//  SmallDay
//
//  Created by wuqh on 15/10/12.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUTabBarController.h"

#import "WUExploreViewController.h"
#import "WUExperienceViewController.h"  
#import "WUClassifyViewController.h"
#import "WUMyViewController.h"
//@class WUBaseViewController;

@interface WUTabBarController ()

@end

@implementation WUTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatViewControllers]; 
}

- (void)creatViewControllers {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"viewControllers" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *viewControllerArr = @[].mutableCopy;
    for (NSDictionary *dict in array) {
       
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:dict[@"storyBoard"] bundle:[NSBundle mainBundle]];
        WUBaseViewController *viewController = [storyBoard instantiateViewControllerWithIdentifier:dict[@"storyBoard"]];
        viewController.tabBarItem.image = [[UIImage imageNamed:[dict[@"iconName"] stringByAppendingString:@"_1"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.tabBarItem.selectedImage = [[UIImage imageNamed:[dict[@"iconName"] stringByAppendingString:@"_2"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.title = dict[@"title"];
        [viewControllerArr addObject:viewController];
    }
    self.viewControllers = viewControllerArr;
    self.tabBar.tintColor = [UIColor blackColor];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
