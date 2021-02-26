//
//  InputCollector.m
//  Lab4
//
//  Created by Takayasu Nasu on 2021/02/25.
//

#import "InputCollector.h"

@implementation InputCollector


- (NSString *) inputForPrompt: (int) maxLength And: (NSString *) prompt
{
  if (maxLength < 1) {
    maxLength = 255;
  }

  NSLog(@"%@", prompt);

  char inputChars[maxLength];
  char *result = fgets(inputChars, maxLength, stdin);

  if (result != NULL) {
    NSString *objCString = [NSString stringWithUTF8String:inputChars];
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedInput = [objCString stringByTrimmingCharactersInSet: whitespaces];
    return trimmedInput;
  }
  return prompt;
}

@end
