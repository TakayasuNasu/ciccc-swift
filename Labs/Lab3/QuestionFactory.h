//
//  QuestionFactory.h
//  Lab3
//
//  Created by Takayasu Nasu on 2021/02/26.
//

#import <Foundation/Foundation.h>
#import "Question.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuestionFactory : NSObject

@property NSArray *questionSubclassNames;

- (Question *) generateRandomQuestion;

@end

NS_ASSUME_NONNULL_END
