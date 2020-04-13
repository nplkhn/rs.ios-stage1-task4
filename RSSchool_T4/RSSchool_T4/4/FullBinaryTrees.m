#import <Foundation/Foundation.h>
#import "FullBinaryTrees.h"


@interface NSPointerArray (QueueExpand)
- (id) removeFromQueue;
- (void)addToQueue:(id)obj;
@end

@implementation NSPointerArray (QueueExpand)
- (id) removeFromQueue {
    id head = [self pointerAtIndex:0];
    [self removePointerAtIndex:0];
    return head;
}

- (void) addToQueue:(id)anObject {
    [self addPointer:anObject];
}
@end

@interface Node : NSObject

@property (nonatomic, retain) Node *left;
@property (nonatomic, retain) Node *right;

@end

@implementation Node

- (NSString *)description {
    NSPointerArray *array = [NSPointerArray new];
    NSMutableString *string = [NSMutableString stringWithString:@"["];
    
    [array addToQueue:self];
    Node* current = nil;
    
    while (array.count)
    {
        current = [array removeFromQueue];
        if(string.length > 1){
            [string appendString:@","];
        }
        if(current){
            [string appendString:@"0"];
            [array addToQueue:current.left];
            [array addToQueue:current.right];
        } else {
            [string appendString:@"null"];
        }
        
    }
    NSRange lastNodePosition = [string rangeOfString:@"0" options:NSBackwardsSearch];
    string = [[string substringToIndex:lastNodePosition.location+1] mutableCopy];
    [string appendString:@"]"];
    return string;
}
@end

@implementation FullBinaryTrees

- (NSString *)stringForNodeCount:(NSInteger)count {
    if(count % 2 == 0) return @"[]";
    
    NSArray *trees = [self buildTrees:count];
    NSMutableString *result = [NSMutableString stringWithString:@"["];
    for(Node *tree in trees){
        [result appendString:tree.description];
    }
    [result appendString:@"]"];
    return result;
}

-(NSArray*)buildTrees:(NSInteger)count{
    NSMutableDictionary *treeDict = [NSMutableDictionary new];
    if(![treeDict objectForKey:@(count)]){
        NSMutableArray *tree = [NSMutableArray new];
        if(count == 1){
            [tree addObject:[Node new]];
        } else if(count % 2 == 1){
            for(int i = 0; i < count; i++){
                NSInteger j = count - 1 - i;
                for(Node *left in [self buildTrees:i]){
                    for(Node *right in [self buildTrees:j]){
                        Node *node = [Node new];
                        node.left = left;
                        node.right = right;
                        [tree addObject:node];
                    }
                }
            }
        }
        treeDict[@(count)] = tree;
    }
    return [[treeDict objectForKey:@(count)] copy];
}

@end
