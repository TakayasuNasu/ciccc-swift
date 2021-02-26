//
//  main.m
//  Lab4
//
//  Created by Takayasu Nasu on 2021/02/25.
//

#import <Foundation/Foundation.h>
#import "InputCollector.h"
#import "Contact.h"
#import "ContactList.h"

int main(int argc, const char * argv[]) {
  @autoreleasepool {

    NSMutableArray *programmingLanguage = [NSMutableArray arrayWithObjects:@"Objective-C", @"Swift", nil];
    [programmingLanguage addObject:@"Python"];
    NSLog(@"%@", programmingLanguage[2]);

    InputCollector *inputCollector = [InputCollector new];
    ContactList *contactList = [ContactList new];

    while (YES) {
      NSString *startOrCancel = [inputCollector inputForPrompt:255 And: @"What would you like to do next? \n new - Create a new contact \n list - List all contacts \n quit - Exit Application \n show - Show saved contact if you have \n"];
      if ([startOrCancel isEqualToString: @"q"]) {
        break;
      }
      if ([startOrCancel isEqualToString: @"quit"]) {
        break;
      }

      if ([startOrCancel isEqualToString: @"new"]) {
        Contact *contact = [Contact new];
        NSString *inputName = [inputCollector inputForPrompt: 255 And: @"Enter your name"];
        [contact setName:inputName];
        NSString *inputEmail = [inputCollector inputForPrompt: 255 And: @"Enter your email"];
        [contact setEmail:inputEmail];
        [[contactList contacts] addObject:contact];
      }
      if ([startOrCancel isEqualToString: @"list"]) {
        for (Contact *contact in [contactList contacts]) {
          NSLog(@"name = %@", [contact name]);
          NSLog(@"email = %@", [contact email]);
        }
      }
      if ([startOrCancel isEqualToString: @"show"]) {
        NSInteger selectedNumber = [[inputCollector inputForPrompt:255 And: @"Enter Contact Number"] intValue];
        if ([[contactList contacts]count] >= selectedNumber) {
          NSLog(@"%@", [[contactList contacts][selectedNumber - 1]name]);
          NSLog(@"%@", [[contactList contacts][selectedNumber - 1]email]);
        }
      }
    }
  }
  return 0;
}
