//
//  InputHandler.h
//  Lab3
//
//  Created by Takayasu Nasu on 2021/02/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputHandler : NSObject

- (NSString *) getUserInput: (int) maxLength And: (NSString *) prompt;

@end

NS_ASSUME_NONNULL_END
