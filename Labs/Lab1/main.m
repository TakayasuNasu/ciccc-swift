//
//  main.m
//  Labs
//
//  Created by Takayasu Nasu on 2021/02/22.
//

#import <Foundation/Foundation.h>

NSString *getUserInput(int maxLength, NSString *prompt) {
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

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    while (YES) {
      NSString *strInput = getUserInput(255, @"\nEnter you String ('q' to quit): *");
      if ([strInput isEqualToString:@"q"]) {
        break;
      }

      while (YES) {
        NSString *option = getUserInput(10, @"\nChoose one of the following options:\n1. Uppercase\n2. Lowercase\n3. Numberize\n4. Canadianize\n5. Respond\n6. De-Space-It\n7. Word Count\n8. Remove Punctuations\n9. Done\n");
        if ([option isEqualToString:@"1"]) {
          NSLog(@"%@", [strInput uppercaseString]);
        } else if ([option isEqualToString:@"2"]) {
          NSLog(@"%@", [strInput lowercaseString]);
        } else if ([option isEqualToString:@"3"]) {
          if ([strInput isEqualToString:@"0"]) {
            NSLog(@"%d", [strInput intValue]);
            continue;
          }
          if ([strInput intValue] == 0) {
            NSLog(@"%@", @"Not number");
          } else {
            NSLog(@"%d", [strInput intValue]);
          }
        } else if ([option isEqualToString:@"4"]) {
          NSLog(@"%@", [strInput capitalizedString]);
        } else if ([option isEqualToString:@"5"]) {
          if ([strInput hasSuffix:@"?"]) {
            NSLog(@"%@", @"I don't know.");
          } else if ([strInput hasSuffix:@"!"]) {
            NSLog(@"%@", @"Whoa, calm down!");
          }
        } else if ([option isEqualToString:@"6"]) {
          NSLog(@"%@", [strInput stringByReplacingOccurrencesOfString: @" " withString: @"-"]);
        } else if ([option isEqualToString:@"7"]) {
          NSLog(@"%lu", (unsigned long)[strInput length]);
        } else if ([option isEqualToString:@"8"]) {
          NSLog(@"%@", [strInput stringByReplacingOccurrencesOfString: @"." withString: @""]);
        } else if (option == nil || [option isEqualToString:@"9"]) {
          break;
        } else {
          NSLog(@"Not available.");
        }
      }
    }
  }
  return 0;
}
