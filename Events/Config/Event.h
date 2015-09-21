//
//  Event.h
//  Events
//
//  Created by Abraao Barros Lacerda on 21.09.15.
//  Copyright © 2015 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ProgrammTab,
    TeilnehmerTab,
    ReferentenTab,
    AustellerTab,
    KolloquiumTab,
    WerttbewerbTab,
    FinalistenTab,
    FraunhoferIPTTab,
    WzlTab,
    PartnerTab,
    AachenTab,
    FotosTab,
    AktualisierenTab,
    ImpressumTab,
    LogoutTab,
    
    EventTabcount
} EventTab;

@interface Event : NSObject

-(NSDictionary *)getTabsEvent;
-(int) getIdEvent;

-(NSString *) getTitleOfTab:(long)tab;
-(UIImage *) getIconOfTab :(long)tab;

@end
