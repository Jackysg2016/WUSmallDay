//
//  WUExploreThemeModel.h
//  SmallDay
//
//  Created by wuqh on 15/10/12.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

/*
 {
 "themeurl": "http://api.xiaorizi.me/api/themedetail/?themeid=287",
 "img": "http://pic.huodongjia.com/event/2015-10-08/event141621.jpg",
 "title": "国饮的新旧传承",
 "text": "<body><p>中国茶道是东方文化的瑰宝，它表现为四大理念：天人合一、物我玄会是哲学基础；智者乐水、仁者乐山是人文思索； 涤除玄鉴、澄怀味象是审美诉求；道法自然、保合太和是茶道美学的基本法则。四大支柱互相依存，共同构筑着茶道美学大厦。</p><p>而我们却认为饮茶是老年人的乐趣，我们不懂茶，也就懒去喝茶了。但总有那么一群人希望茶作为我们的国饮，也能受到年轻人的欢迎，让喝茶这件事也符合我们的时尚、活跃、不想跟老土的东西搭边，也不想过于附庸风雅的年轻个性。</p><p>于是他们将传统的茶叶与富有时尚快捷的工具相结合，这种颠覆观念的方式，其新奇之处就在于改变人们喝茶老气的既定看法，在赋予茶新生命活力的同时，也让茶跳离年龄圈层的限制，更加趋于年轻化和时尚化，使茶真正成为一种日常饮品为大众所接受。</p></body>",
 "hasweb": 0,
 "height": 400,
 "width": 640,
 "begin_time": "2015-10-10",
 "keywords": "交替 融合 创新",
 "id": 287
 }
 */

#import "WUBaseModel.h"

@interface WUExploreThemeModel : WUBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *keywords;
@property (nonatomic, copy) NSString *img;

@end
