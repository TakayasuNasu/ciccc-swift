//
//  AdditionQuestion.m
//  Lab3
//
//  Created by Takayasu Nasu on 2021/02/24.
//

#import "AdditionQuestion.h"

@implementation AdditionQuestion

- (NSInteger) getCorrectAnswer
{
  // arc4random_uniform
  int left = (int)arc4random_uniform(100);
  int right = (int)arc4random_uniform(100);
  NSLog(@"%d + %d = ", left, right);
  return left + right;
}

- (NSInteger) verify: (NSInteger) correctAnswer AndYourAnswer: (NSString *) answer
{
  int answerNumber = [answer intValue];

  if (correctAnswer == answerNumber) {
    NSLog(@"Right!");
    return 1;
  } else {
    NSLog(@"Wrong!");
    return -1;
  }
}

@end
