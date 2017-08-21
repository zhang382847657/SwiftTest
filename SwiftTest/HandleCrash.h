//
//  HandleCrash.h
//  SwiftTest
//
//  Created by 张琳 on 2017/8/21.
//  Copyright © 2017年 张琳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HandleCrash : NSObject

+ (NSString *)crash:(int)signal;
@end
