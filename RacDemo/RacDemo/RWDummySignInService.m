//
//  RWDummySignInService.m
//  RacDemo
//
//  Created by jinxin on 18/09/2017.
//  Copyright © 2017 jinxin. All rights reserved.
//

#import "RWDummySignInService.h"

@implementation RWDummySignInService

- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(RWSignInResponse)completeBlock {
	
	double delayInSeconds = 1.0;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		BOOL success = [username isEqualToString:@"user"] && [password isEqualToString:@"password"];
		completeBlock(success);
	});
}


@end
