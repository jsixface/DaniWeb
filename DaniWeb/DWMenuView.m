//
//  DWMenuView.m
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 3/1/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import "DWMenuView.h"
#import "UIColor+ColourTheme.h"

@implementation DWMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setFrame:frame];
        [self setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        [self setBackgroundColor:[UIColor DWMenuBackColour]];
//        [self setRowHeight:30];
        [self setSeparatorColor:[UIColor DWMenuLineColour]];
        [self setSectionIndexColor:[UIColor whiteColor]];
        [self setSectionIndexBackgroundColor:[UIColor DWMenuBackColour]];

        return self;
    }
    return nil;
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
