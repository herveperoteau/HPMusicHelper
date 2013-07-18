//
//  HPMusicHelper.m
//  HPMusicHelper
//
//  Created by Hervé PEROTEAU on 17/07/13.
//  Copyright (c) 2013 Hervé PEROTEAU. All rights reserved.
//

#import "HPMusicHelper.h"

@implementation HPMusicHelper

// Ex : The Strokes => strokes
+(NSString *) cleanArtistName:(NSString *) artist {

    return [HPMusicHelper cleanInfos:artist];
}

//    Ex: Scream & Shout (feat. Britney Spears) => scream & shout
+(NSString *) cleanSongTitle:(NSString *) title {
    
    return [HPMusicHelper cleanInfos:title];
}

+(NSString *) cleanInfos:(NSString *) info {

    NSString *result = [info stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSLocale *locale = [NSLocale currentLocale];
    result = [result lowercaseStringWithLocale:locale];
    
    result = [HPMusicHelper cleanAccents:result];
    result = [HPMusicHelper cleanPrefixe:result];
    result = [HPMusicHelper cleanInfosFeat:result];
    
    return result;
}

+(NSString *) cleanAccents:(NSString *) item {

    return [item stringByFoldingWithOptions: NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
}

//    les strokes => strokes
+(NSString *) cleanPrefixe:(NSString *) item {
    
    NSString *result = item;
    
    NSArray *prefixes = @[@"les ", @"the "];
    
    for (NSString *prefix in prefixes) {
        
        NSRange range = [result rangeOfString:prefix];
        
        if (range.location == 0) {
            
            result = [result substringFromIndex:range.length];
            break;
        }
    }
    
    return result;
}

//    Ex: Scream & Shout (feat. Britney Spears) => Scream & Shout
+(NSString *) cleanInfosFeat:(NSString *) title {
    
    NSString *result = title;
    
    result = [self cleanString:result after:@"("];
    result = [self cleanString:result after:@"ft"];
    result = [self cleanString:result after:@"feat"];
    
    return result;
}

+(NSString *) cleanString:(NSString *)str after:(NSString *)aVirer {
    
    NSString *result = str;
    
    NSRange search = [str rangeOfString:aVirer];
    
    if (search.location != NSNotFound) {
        
        result = [result substringToIndex:search.location];
        result = [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    
    return result;
}


@end
