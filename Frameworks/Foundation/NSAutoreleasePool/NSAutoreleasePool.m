/* Copyright (c) 2006-2007 Christopher J. W. Lloyd

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. */

#import <Foundation/NSAutoreleasePool.h>
#import <Foundation/NSException.h>
#import <Foundation/NSRaise.h>
#import <Foundation/NSString.h>
#import <Foundation/NSThread-Private.h>
#import <Foundation/NSRaiseException.h>

#import <objc/objc-arc.h>

@implementation NSAutoreleasePool

+(void)addObject:object {
    objc_autorelease(object);
}

-init {
    _pool=objc_autoreleasePoolPush();
   return self;
}

-(void)dealloc {
    objc_autoreleasePoolPop(_pool);

   [super dealloc];
}

-(void)addObject:object {
    objc_autoreleasePoolAdd(_pool,object);
}

id NSAutorelease(id object){
    return objc_autorelease(object);
}

-(void)drain {
	[self release];
}

-retain {
   [NSException raise:NSInvalidArgumentException format:@"-[NSAutoreleasePool retain] not allowed"];
   return nil;
}
// indicate this class is ARC compatible
-(void)_ARCCompatibleAutoreleasePool {}

@end
