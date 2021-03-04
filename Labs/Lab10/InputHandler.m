//
//  InputHandler.m
//  Lab10
//
//  Created by Takayasu Nasu on 2021/03/03.
//

#import "InputHandler.h"

@implementation InputHandler


- (NSString *) getUserInput: (int) maxLength And: (NSString *) prompt
{
  if (maxLength < 1) {
    maxLength = 255;
  }

  if ([prompt length] > 0) {
    NSLog(@"%@", prompt);
  }

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
