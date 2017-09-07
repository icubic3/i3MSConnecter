//
//  MSFriendModel.m
//  i3MSConnecter
//
//  Created by i3 on 2017/8/11.
//  Copyright © 2017年 com.breo. All rights reserved.
//

#import "MSFriendModel.h"
#import <objc/runtime.h>

@implementation MSFriendModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        id value = [self valueForKeyPath:key];
        
        [aCoder encodeObject:value forKey:key];
    }//利用runtime进行归档
    free(ivars);
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        
        for (int i = 0; i < outCount ; i++) {
            Ivar ivar = ivars[i];
            
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            id value = [aDecoder decodeObjectForKey:key];
            
            [self setValue:value forKeyPath:key];
        }//解归档
        
        free(ivars);
        
    }
    return self;
}

@end
