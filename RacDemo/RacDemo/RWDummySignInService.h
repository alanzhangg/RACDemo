//
//  RWDummySignInService.h
//  RacDemo
//
//  Created by jinxin on 18/09/2017.
//  Copyright © 2017 jinxin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RWSignInResponse)(BOOL);

@interface RWDummySignInService : NSObject

- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(RWSignInResponse)completeBlock;

@end
