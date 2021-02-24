//
//  DateCalculator.h
//  Lab2
//
//  Created by Takayasu Nasu on 2021/02/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateCalculator : NSObject

@property (readonly) NSString *name;
@property float age;

- (instancetype)initWithName: (NSString *) name AndAge: (float) age;
- (BOOL) canDateAPersonWithAge: (float) age;

@end

NS_ASSUME_NONNULL_END
