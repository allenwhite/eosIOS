//
//  AFAPIclient.h
//  EOS
//
//  Created by Allen White on 11/14/15.
//  Copyright © 2015 ScheduleFour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface AFAPIclient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
