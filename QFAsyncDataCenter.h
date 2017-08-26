//
//  QFAsyncDataCenter.h
//  QFAsyncDataCenter
//
//  Created by dqf on 2017/8/25.
//  Copyright © 2017年 dqfStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QFAsyncDataCenter : NSObject

+ (QFAsyncDataCenter *)share;

- (UIWindow *)rootWindow;
- (UINavigationController *)rootVC;
- (NSString *)showVC;

#pragma -set/get

- (void)setObject:(NSString *)anObject forKey:(NSString *)aKey;
- (NSString *)objectForKey:(NSString *)aKey;
- (void)removeObjectForKey:(NSString *)aKey;

@end

@interface QFAsyncDataCenter (asyncData)

- (void)setClass:(NSString *)classKey object:(NSString *)anObject key:(NSString *)aKey;
- (NSString *)objectForClass:(NSString *)classKey key:(NSString *)aKey;
- (void)removeClass:(NSString *)classKey key:(NSString *)aKey;
- (void)removeObjectForClass:(NSString *)classKey;

- (NSString *)showVCObjectForKey:(NSString *)aKey;
- (void)popVC:(UIViewController *)vc;

@end

@interface UIView (asyncData)

- (void)setObject:(NSString *)anObject key:(NSString *)aKey;
- (NSString *)objectForKey:(NSString *)aKey;
- (void)removeObjectForKey:(NSString *)aKey;
- (void)removeAllObject;

#pragma -class key

- (void)setClass:(NSString *)classKey object:(NSString *)anObject key:(NSString *)aKey;
- (NSString *)objectForClass:(NSString *)classKey key:(NSString *)aKey;
- (void)removeClass:(NSString *)classKey key:(NSString *)aKey;
- (void)removeClass:(NSString *)classKey;

@end

@interface UIViewController (asyncData)

- (void)setObject:(NSString *)anObject key:(NSString *)aKey;
- (NSString *)objectForKey:(NSString *)aKey;
- (void)removeObjectForKey:(NSString *)aKey;
- (void)removeAllObject;

#pragma -class key

- (void)setClass:(NSString *)classKey object:(NSString *)anObject key:(NSString *)aKey;
- (NSString *)objectForClass:(NSString *)classKey key:(NSString *)aKey;
- (void)removeClass:(NSString *)classKey key:(NSString *)aKey;
- (void)removeClass:(NSString *)classKey;

@end

@interface NSString (asyncData)

- (NSString *(^)(id))append;
- (NSString *(^)(NSString *, NSString *))replace;

@end
