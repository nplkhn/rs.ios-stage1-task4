#import "TelephoneFinder.h"

@implementation TelephoneFinder
- (NSArray <NSString*>*)findAllNumbersFromGivenNumber:(NSString*)number {
    if (number.intValue < 0) {
        return nil;
    }
    
    NSArray *neighbors = @[@[@"8"], @[@"2", @"4"], @[@"3", @"5", @"1"], @[@"2", @"6"], @[@"1", @"5", @"7"], @[@"2", @"6", @"8", @"4"], @[@"3", @"9", @"5"], @[@"4", @"8"], @[@"5", @"9", @"0", @"7"], @[@"6", @"8"]];
    NSArray *keys = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:neighbors forKeys: keys];
    NSMutableArray *result = [NSMutableArray new];
    
    for (int i = 0; i < number.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *key = [[NSString alloc] initWithString:[number substringWithRange:range]];
        NSArray* values  = [dict valueForKey:key];
        [values enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [result addObject: [number stringByReplacingCharactersInRange:range withString:obj]];
        }];
    }

    return result;
}
@end
