//
//  QuestionFactory.m
//  Lab3
//
//  Created by Takayasu Nasu on 2021/02/26.
//

#import "QuestionFactory.h"
#import "Question.h"

@implementation QuestionFactory

- (instancetype)init
{
  self = [super init];
  if (self) {
    _questionSubclassNames =  @[
      @"AdditionQuestion",
      @"SubtractionQuestion",
      @"MultiplicationQuestion",
      @"DivisionQuestion"];

  }
  return self;
}
- (Question *)generateRandomQuestion
{
  int questionIndex = arc4random_uniform((int)[_questionSubclassNames count]);
  return [[NSClassFromString(_questionSubclassNames[questionIndex]) alloc] init];
}

@end
