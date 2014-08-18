


#define UPDATEVALUE(key,value){\
[[NSUserDefaults standardUserDefaults] setValue:value forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

#define REMOVEVALUE(key){\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

#define GETVALUE(key)[[NSUserDefaults standardUserDefaults] objectForKey:key]

#define kDefaults [NSUserDefaults standardUserDefaults]

#define HUD_COLOR [UIColor colorWithRed:101.0/255.0 green:171.0/255.0 blue:53.0/255.0 alpha:1.0]

#define MSG_COLOR_GREEN [UIColor colorWithRed:101.0/255.0 green:171.0/255.0 blue:53.0/255.0 alpha:1.0]

#define MSG_COLOR_RED [UIColor colorWithRed:189.0/255.0 green:21.0/255.0 blue:16.0/255.0 alpha:1.0]

#define MSG_COLOR_YELLOW [UIColor colorWithRed:208.0/255.0 green:180.0/255.0 blue:49.0/255.0 alpha:1.0]

#define COMMON_COLOR_RED [UIColor colorWithRed:252.0/255.0 green:95.0/255.0 blue:66.0/255.0 alpha:1.0]
#define COMMON_COLOR_GRAY [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:243.0/255.0 alpha:1.0]
#define COMMON_COLOR_DATE [UIColor colorWithRed:135.0/255.0 green:135.0/255.0 blue:135.0/255.0 alpha:1.0]


#define BASE_URL @"http://acs.bookingshow.com/api/v1/service.svc/"




#if DEBUGGING
    #warning "App in Debug Mode"
#endif

#define IsEmpty(value) (value == (id)[NSNull null] || value == nil || ([value isKindOfClass:[NSString class]] && ([value isEqualToString:@""] ||  [value isEqualToString:@"<null>"]))) ? YES : NO

#define IfNULL(original, replacement) IsNULL(original) ? replacement : original

#define IsNULL(original) original == (id)[NSNull null]

#define SafeString(value) IfNULL(value, @"")

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )



#define TITLE_TEXT_COLOR [UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:1.0]




#define APP_IDENTIFIER [[NSBundle mainBundle] bundleIdentifier]
#define TextFont(SIZE)[UIFont fontWithName:@"Montserrat-Regular" size:SIZE]
