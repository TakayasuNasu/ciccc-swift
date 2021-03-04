//
//  InputHandler.h
//  Lab10
//
//  Created by Takayasu Nasu on 2021/03/03.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputHandler : NSObject

- (NSString *) getUserInput: (int) maxLength And: (NSString *) prompt;

@end

NS_ASSUME_NONNULL_END
