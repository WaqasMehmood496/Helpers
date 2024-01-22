//
//  BInterfaceManager.h
//  Pods
//
//  Created by Benjamin Smiley-andrews on 14/09/2016.
//
//

#import <Foundation/Foundation.h>

@protocol PInterfaceAdapter;

@interface BInterfaceManager : NSObject

+(BInterfaceManager *) shared;
-(id<PInterfaceAdapter>) a;

@end
