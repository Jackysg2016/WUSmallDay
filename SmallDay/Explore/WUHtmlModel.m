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

- (instancetype)init {
    if (self = [super init]) {
        self.imgWidth = SCREEN_WIDTH - 10;
    }
    return self;
}

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
                        model.imgUrl = subElement.attributes[@"src"];
                        
                        [dataArr addObject:model];
                    }
                }
            }
            if (element.content.length > 0) {
                WUHtmlModel *model = [WUHtmlModel new];
                model.isImg = NO;
                model.text = element.content;
                model.textHeight = [self heightForContent:element.content];
                [dataArr addObject:model];
            }
        }else{
            if (element.content.length > 0) {
                WUHtmlModel *model = [WUHtmlModel new];
                model.isImg = NO;
                model.text = element.content;
                model.textHeight = [self heightForContent:element.content];
                [dataArr addObject:model];
            }
        }
        
    }
    return dataArr;

}

+ (CGFloat)heightForContent:(NSString *)content{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4;
    CGRect rect = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-10, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle} context:nil];
    NSLog(@"%@ \n %f",content,rect.size.height);
    return rect.size.height;
}

@end
