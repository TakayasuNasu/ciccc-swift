//
//  AdditionQuestion.h
//  Lab3
//
//  Created by Takayasu Nasu on 2021/02/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdditionQuestion : NSObject

- (NSInteger) getCorrectAnswer;
- (NSInteger) verify: (NSInteger) correctAnswer AndYourAnswer: (NSString *) answer;

@end

NS_ASSUME_NONNULL_END
