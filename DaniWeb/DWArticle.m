//
//  DWArticle.m
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 7/6/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import "DWArticle.h"

@implementation DWArticle

-(NSString *)description
{
    return [NSString stringWithFormat:@"ID: %@, ------- title : %@", self.title, self.articleId];
}

@end
