//
//  WUHtmlTextCell.m
//  SmallDay
//
//  Created by wuqh on 15/10/15.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUHtmlTextCell.h"
#import "WUHtmlModel.h"

@interface WUHtmlTextCell()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end

@implementation WUHtmlTextCell

+ (instancetype)htmlTextCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    // Initialization code
    self.contentLabel.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateUIWithModel:(WUHtmlModel *)model {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:model.text];
    if (model.isBold) {
        
        [attributedStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, model.text.length)];
    }else {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 4;
        [attributedStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor grayColor],NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, model.text.length)];
    }
    self.contentLabel.attributedText = attributedStr;
}
@end
