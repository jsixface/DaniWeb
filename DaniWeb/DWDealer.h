//
//  DWDealer.h
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 3/29/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWDealer : NSObject

-(NSArray *) getSubMenuForItemID:(NSInteger) parendId;
-(NSArray*) getContentForForumID:(NSString*) forumId;
@end
