//
//  NSArray+Random.m
//  test
//
//  Created by thomas on 2017/1/9.
//  Copyright © 2017年 tedu. All rights reserved.
//

#import "NSArray+Random.h"
#import <objc/runtime.h>
@implementation NSArray (Random)
static char prevKey;
static int random_value(void){
    static unsigned long rnd = 20101008;
    rnd = rnd *1103515245UL+12345;
    return (int)((rnd>>16)&0x7fff);
}
-(id)anyOne{
    id item;
    NSUInteger count = [self count];
    if(count ==0)
        return nil;
    if(count ==1)
        item = [self lastObject];
    else{
        id prev = objc_getAssociatedObject(self, &prevKey);   //初次使用关联引用时返回nil
        NSUInteger index = random_value()% count;
        item = [self objectAtIndex: index];
        if( item == prev) {
            if (++index >= count)
                index=0;
            item = [self objectAtIndex:index];
        }
    }
    objc_setAssociatedObject(self, &prevKey, item, OBJC_ASSOCIATION_RETAIN);//存储最后返回的对象。
    return item;
}
@end
