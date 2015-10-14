//
//  WUExploreStoreDiscoveryViewController.m
//  SmallDay
//
//  Created by wuqh on 15/10/13.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUExploreStoreDiscoveryViewController.h"

#import "WUExploreEventModel.h"

@interface WUExploreStoreDiscoveryViewController ()

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WUExploreEventModel *model;
@end

@implementation WUExploreStoreDiscoveryViewController

- (instancetype)initWithModel:(WUExploreEventModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(300, 0, 0, 0);
    
    [self.view addSubview:self.webView];
    [self.webView loadHTMLString:[self processHtml] baseURL:[NSURL URLWithString:[[NSBundle mainBundle] bundlePath]]];
}

#pragma mark - 加工html
- (NSString *)processHtml {
    CGFloat imageWidth = self.view.bounds.size.width -20;
    
    NSError *error;
    NSRegularExpression *regexWidth = [NSRegularExpression regularExpressionWithPattern:@"(?<=width=\")\\d*" options:0 error:&error];
    
    NSMutableArray *widthArray = @[].mutableCopy;
    NSLog(@"%@",self.model.mobileURL);
    NSArray *widthResults = [regexWidth matchesInString:self.model.mobileURL options:0 range:NSMakeRange(0, self.model.mobileURL.length)];
    for (NSTextCheckingResult *result in widthResults) {
        NSString *match = [self.model.mobileURL substringWithRange:result.range];
        [widthArray addObject:match];
    }
    NSMutableArray *mut = @[].mutableCopy;
    for (NSString *width in widthArray) {
        
        
        NSNumber *proportion = [NSNumber numberWithFloat:[width floatValue]/imageWidth];
        [mut addObject:proportion];
    }
    
    
    NSMutableString *processedURL = self.model.mobileURL.mutableCopy;
    for (NSInteger i = widthResults.count - 1; i >= 0; i--) {
        NSTextCheckingResult *widthMatch =  widthResults[i];
        
        
        [processedURL replaceCharactersInRange:widthMatch.range withString:[NSString stringWithFormat:@"%f",imageWidth]];
        
        
    }
    
    return processedURL;
    
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
