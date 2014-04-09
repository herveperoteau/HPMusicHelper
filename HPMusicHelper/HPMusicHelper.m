//
//  HPMusicHelper.m
//  HPMusicHelper
//
//  Created by Hervé PEROTEAU on 17/07/13.
//  Copyright (c) 2013 Hervé PEROTEAU. All rights reserved.
//

#import "HPMusicHelper.h"

static NSMutableDictionary *cacheArtist;
static NSMutableDictionary *cacheArtistPreserveAccent;

@implementation HPMusicHelper

+(NSString *) cleanArtistName:(NSString *) artist {
    
    if (artist==nil) {
        return @"";
    }
    
    return [self.class cleanArtistName:artist PreserveAccent:YES PreservePrefix:YES];
}

// Ex : The Strokes => strokes
+(NSString *) cleanArtistName:(NSString *) artist PreserveAccent:(BOOL)preserveAccent PreservePrefix:(BOOL)preservePrefix{
    
    if (artist==nil) {
        return @"";
    }

    NSString *cleanResult;
    
    // check in cache
    NSMutableDictionary *cache = cacheArtist;
    if (preserveAccent) {
        cache = cacheArtistPreserveAccent;
    }
    
    if (cache) {
        cleanResult = [cache valueForKey:artist];
        if (cleanResult) {
            return cleanResult;
        }
    }
    
    // not in cache, calculate ...
    cleanResult = [HPMusicHelper cleanInfos:artist PreserveAccent:preserveAccent PreservePrefix:preservePrefix];
    
    // save in cache
    if (cache == nil) {
        if (preserveAccent) {
            cacheArtistPreserveAccent = [[NSMutableDictionary alloc] init];
            cache = cacheArtistPreserveAccent;
        }
        else {
            cacheArtist = [[NSMutableDictionary alloc] init];
            cache = cacheArtist;
        }
    }
    
    [cache setValue:cleanResult forKey:artist];
    
    return cleanResult;
}

+(NSString *) cleanSongTitle:(NSString *) title{
    
    if (title==nil) {
        return @"";
    }

    return [self.class cleanSongTitle:title PreserveAccent:YES];
}

//    Ex: Scream & Shout (feat. Britney Spears) => scream & shout
+(NSString *) cleanSongTitle:(NSString *) title PreserveAccent:(BOOL)preserveAccent {
    
    if (title==nil) {
        return @"";
    }

    return [HPMusicHelper cleanInfos:title PreserveAccent:preserveAccent PreservePrefix:YES];
}

+(NSString *) cleanAlbumTitle:(NSString *) title {
    
    if (title==nil) {
        return @"";
    }

    return [HPMusicHelper cleanAlbumTitle:title PreserveAccent:NO];
}

+(NSString *) cleanAlbumTitle:(NSString *) title PreserveAccent:(BOOL)preserveAccent {
    
    if (title==nil) {
        return @"";
    }

    NSString *result = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSLocale *locale = [NSLocale currentLocale];
    result = [result lowercaseStringWithLocale:locale];
    
    if (!preserveAccent) {
        result = [HPMusicHelper cleanAccents:result];
    }
    
    result = [HPMusicHelper cleanParenthese:result];
    
    //01, title
    result = [HPMusicHelper cleanNumAlbumInTitle:result];
    
    return result;
}

+(NSString *) cleanNumAlbumInTitle:(NSString *) title {
    
    if (title==nil) {
        return @"";
    }

    NSString *result = [NSString stringWithString:title];
    
    //01, title
    NSRange rangePrefixNumber = [result rangeOfString:@"^\\d{1,2}[ *,.~:-]" options:NSRegularExpressionSearch];
    if (rangePrefixNumber.location != NSNotFound) {
        result = [result substringFromIndex:rangePrefixNumber.location+rangePrefixNumber.length];
        result = [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    
    return result;
}

+(NSString *) cleanInfos:(NSString *) info {
    
    if (info==nil) {
        return @"";
    }

    return [self.class cleanInfos:info PreserveAccent:YES PreservePrefix:YES];
}

+(NSString *) cleanInfos:(NSString *) info PreserveAccent:(BOOL)preserveAccent PreservePrefix:(BOOL)preservePrefx {
    
    if (info==nil) {
        return @"";
    }

    NSString *result = [info stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSLocale *locale = [NSLocale currentLocale];
    result = [result lowercaseStringWithLocale:locale];
    
    if (!preserveAccent) {
        result = [HPMusicHelper cleanAccents:result];
    }
    
    if (!preservePrefx) {
        result = [HPMusicHelper cleanPrefixe:result];
    }
    
    result = [HPMusicHelper cleanInfosFeat:result];
    result = [HPMusicHelper cleanParenthese:result];
    
    return result;
}

+(NSString *) cleanAccents:(NSString *) item {
    
    if (item==nil) {
        return @"";
    }

    NSMutableString *string = [item mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)(string), NULL, kCFStringTransformStripCombiningMarks, NO);
    return [NSString stringWithString:string];
    //return [item stringByFoldingWithOptions: NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
}

//    les strokes => strokes
+(NSString *) cleanPrefixe:(NSString *) item {
    
    if (item==nil) {
        return @"";
    }

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
    
    if (title==nil) {
        return @"";
    }

    NSString *result = title;
    
    result = [self cleanString:result after:@" ft"];  // Attention si on met ft sans l'espace ca clean Daft Punk en da !!!
    result = [self cleanString:result after:@" feat"];
    
    return result;
}

+(NSString *) cleanParenthese:(NSString *) title {
    
    if (title==nil) {
        return @"";
    }

    NSString *result = title;
    
    result = [self cleanString:result after:@"("];
    result = [self cleanString:result after:@"["];
    
    return result;
}


+(NSString *) cleanString:(NSString *)str after:(NSString *)aVirer {
    
    if (str==nil) {
        return @"";
    }

    NSString *result = str;
    
    NSRange search = [str rangeOfString:aVirer];
    if (search.location != NSNotFound) {
        result = [result substringToIndex:search.location];
        result = [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    
    return result;
}


@end
