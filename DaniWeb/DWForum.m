//
//  DWForum.m
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 7/7/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import "DWForum.h"

@implementation DWForum


-(NSString *)description
{
    return [NSString stringWithFormat:@"Forum ID: %@.         Title: %@ __ %@", self.forumId, self.title, self.children];
}
@end
