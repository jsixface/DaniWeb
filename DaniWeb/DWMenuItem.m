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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self.textLabel setTextColor:[UIColor whiteColor]];
        [self setBackgroundColor:[UIColor clearColor ]];
        [self.textLabel setFont:[UIFont fontWithDescriptor:[UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleSubheadline] size:0]];
        [self setHighlighted:NO];
        [self setSelected:NO];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return self;
    }
    return nil;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
