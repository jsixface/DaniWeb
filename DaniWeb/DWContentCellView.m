//
//  DWContentCellView.m
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 4/9/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import "DWContentCellView.h"
#import <QuartzCore/QuartzCore.h>


@interface DWContentCellView()
@property (strong, nonatomic) IBOutlet UILabel *txtTimeStamp;

@end



@implementation DWContentCellView
{
    NSDateFormatter * _formatter ;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}



-(void)awakeFromNib
{
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setTimeStyle:NSDateFormatterMediumStyle];
    [_formatter setDateStyle:NSDateFormatterShortStyle];
    [_formatter setLocale:[NSLocale currentLocale]];
    
    self.txtTitle.font = [UIFont fontWithName:@"Helvetica" size:16.0];
    self.cellBackgroundView.layer.borderColor = [UIColor blackColor].CGColor;
    self.cellBackgroundView.layer.borderWidth = 0.5;
    

}

-(void)setTitleText:(NSString *)titleText
{
    _titleText = titleText;
    CGSize size = [titleText sizeWithAttributes:@{NSFontAttributeName: self.txtTitle.font}];
    if (size.width < 288)
    {
        CGRect bounds = self.txtTitle.bounds;
        bounds.size.height = bounds.size.height - self.txtTitle.font.lineHeight;
        self.txtTitle.bounds = bounds;
    }
    self.txtTitle.text = _titleText;
}

-(void)setTimestamp:(NSString *)timestamp
{
    _timestamp = timestamp;
    NSDate * date = [[NSDate alloc] initWithTimeIntervalSince1970:[_timestamp doubleValue]];
    NSString * strDate = [_formatter stringFromDate:date];
    self.txtTimeStamp.text = strDate;
}

@end
