//
//  AQDataPointTableCell.m
//  anscombe-quartet-ios
//
//  Created by Terry Worona on 6/21/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import "AQDataPointTableCell.h"

@interface AQDataPointTableCell ()

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation AQDataPointTableCell

#pragma mark - Alloc/Init

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.backgroundColor = [UIColor clearColor];
        _leftLabel.font = [UIFont systemFontOfSize:12.0f];
        _leftLabel.textColor = kQAColorDetailCellTextColor;
        [self addSubview:_leftLabel];

        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.font = [UIFont systemFontOfSize:12.0f];
        _rightLabel.textColor = kQAColorDetailCellTextColor;
        [self addSubview:_rightLabel];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.leftLabel.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, ceil(self.bounds.size.width * 0.5), self.bounds.size.height);
    self.rightLabel.frame = CGRectMake(ceil(self.bounds.size.width * 0.5), self.bounds.origin.y, ceil(self.bounds.size.width * 0.5), self.bounds.size.height);
}

@end
