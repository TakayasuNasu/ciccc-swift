//
//  main.m
//  Lab8-PizzaRestaurant
//
//  Created by Takayasu Nasu on 2021/03/01.
//

#import <Foundation/Foundation.h>
#import "Kitchen.h"

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    NSLog(@"Please pick your pizza size and toppings:");

    Kitchen *restaurantKitchen = [Kitchen new];

    while (TRUE) {

      NSLog(@"> ");
      char str[100];
      fgets (str, 100, stdin);

      NSString *inputString = [[NSString alloc] initWithUTF8String:str];
      inputString = [inputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

      if ([inputString isEqualToString: @"q"]) {
        break;
      }

      NSLog(@"Input was %@", inputString);

      NSArray *commandWords = [inputString componentsSeparatedByString:@" "];
      if ([commandWords count] > 2) {
        Pizza *pizza = [restaurantKitchen order:commandWords];
        NSLog(@"%@",GetPizzaSizeText((int)[pizza size]));
      }
    }
  }
  return 0;
}
