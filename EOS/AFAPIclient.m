//
//  AFAPIclient.m
//  EOS
//
//  Created by Allen White on 11/14/15.
//  Copyright © 2015 ScheduleFour. All rights reserved.
//

#import "AFAPIclient.h"

static NSString * const AFAPIBaseURLString = @"http://54.148.137.189:6969/";

@implementation AFAPIclient

NSString *auth;
+ (instancetype)sharedClient {
	static AFAPIclient *_sharedClient = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:_sharedClient.responseSerializer.acceptableContentTypes];
		[contentTypes addObject:@"application/vnd.api+json"];
		[contentTypes addObject:@"text/html"];
		
		_sharedClient = [[AFAPIclient alloc] initWithBaseURL:[NSURL URLWithString:AFAPIBaseURLString]];
		_sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
		_sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
		_sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
		_sharedClient.responseSerializer.acceptableContentTypes = contentTypes;
	});
	
	return _sharedClient;
}


@end
