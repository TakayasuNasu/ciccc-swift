//
//  main.m
//  Lab3
//
//  Created by Takayasu Nasu on 2021/02/24.
//

#import <Foundation/Foundation.h>
#import "AdditionQuestion.h"
#import "ScoreKeeper.h"
#import "InputHandler.h"

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    AdditionQuestion *question = [[AdditionQuestion alloc] init ];
    InputHandler *inputHandler = [[InputHandler alloc] init];

    while (YES) {
      NSString *startOrCancel = [inputHandler getUserInput:255 And: @"Enter you Answer ('q' to quit): *\n"];
      if ([startOrCancel isEqualToString: @"q"]) {
        break;
      }

      ScoreKeeper *scoreKeeper = [[ScoreKeeper alloc] init];
      NSLog(@"MATHS");
      while (YES) {
        NSInteger correctAnswer = [question getCorrectAnswer];
        NSString *answer = [inputHandler getUserInput:255 And: @""];
        if ([answer isEqualToString: @"q"]) {
          break;
        }
        NSInteger score = [question verify: correctAnswer AndYourAnswer: answer];
        if (score > 0) {
          [scoreKeeper setRight: [scoreKeeper right] + score];
        } else {
          [scoreKeeper setWrong: [scoreKeeper wrong] + 1];
        }
      }

      // 3 / total * 100
      NSInteger ratio = [scoreKeeper right] * 100 / ([scoreKeeper right] + [scoreKeeper wrong]);
      NSLog(@"score: %ld right, %ld wrong ---- %ld%%", (long)[scoreKeeper right], (long)[scoreKeeper wrong], (long)ratio);
    }
  }
  return 0;
}
