//
//  DWMenuItem.m
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 3/1/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import "DWMenuItem.h"
#import "UIColor+ColourTheme.h"

@implementation DWMenuItem

-(id)init
{
    self = [super init];
    if (self) {
        [self.textLabel setTextColor:[UIColor whiteColor]];
        [self.textLabel setNumberOfLines:0];
        [self.textLabel setFont:[UIFont fontWithDescriptor:[UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleSubheadline] size:0]];
        [self setHighlighted:NO];
        [self setBackgroundColor:[UIColor clearColor ]];
        [self setSelected:NO];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return self;
    }
    return nil;
    
}


@end
