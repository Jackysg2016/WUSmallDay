//
//  WUHtmlModel.m
//  SmallDay
//
//  Created by wuqh on 15/10/15.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUHtmlModel.h"

#import "TFHpple.h"
#import "TFHppleElement.h"
#import "XPathQuery.h"
#import "WUHtmlModel.h"

@implementation WUHtmlModel

+ (NSMutableArray *)parseHtml:(NSString *)htmlStr {
    NSMutableArray *dataArr = @[].mutableCopy;
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:[htmlStr dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *array = [xpathParser searchWithXPathQuery:@"//p"];
    for (TFHppleElement *element in array) {
        if (element.children.count > 0) {
            for (TFHppleElement *subElement in element.children) {
                
                if ([subElement.tagName isEqualToString:@"strong"]) {
                    if (subElement.content.length > 0) {
                        WUHtmlModel *model = [WUHtmlModel new];
                        model.isImg = NO;
                        model.text = subElement.content;
                        model.isBold = YES;
                        [dataArr addObject:model];
                    }
                }
                if ([subElement.tagName isEqualToString:@"img"]) {
                    
                    
                    if (subElement.attributes[@"width"]) {
                        
                        
                        CGFloat height = [subElement.attributes[@"height"] floatValue];
                        CGFloat width = [subElement.attributes[@"width"] floatValue];
                        
                        WUHtmlModel *model = [WUHtmlModel new];
                        model.isImg = YES;
                        
                        model.imgHeight = height*model.imgWidth/width;
                        NSLog(@"%f",model.imgHeight);
                        model.imgUrl = subElement.attributes[@"src"];
                        
                        [dataArr addObject:model];
                    }
                }
            }
            
            if (element.content.length > 0) {
                WUHtmlModel *model = [WUHtmlModel new];
                model.isImg = NO;
                model.text = element.content;
                [dataArr addObject:model];
            }
        }else {
            WUHtmlModel *model = [WUHtmlModel new];
            model.isImg = NO;
            model.text = element.content;
            [dataArr addObject:model];
        }
        
    }
    return dataArr;

}

@end
