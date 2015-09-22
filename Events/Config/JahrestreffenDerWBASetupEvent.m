//
//  JahrestreffenDerWBASetupEvent.m
//  Events
//
//  Created by Abraao Barros Lacerda on 21.09.15.
//  Copyright © 2015 Teknowledge Software. All rights reserved.
//

#import "JahrestreffenDerWBASetupEvent.h"
#import "KQNavigationController.h"
#import "LayoutSetup.h"


@implementation JahrestreffenDerWBASetupEvent

NSDictionary *TitleTab;
NSDictionary *IconTab;
NSDictionary *LayoutView;
long actualTab;

-(instancetype)init{
    self = [super init];
    if (self) {
        TitleTab = @{
                    @(ProgrammTab)       : @"Programm",
                    @(TeilnehmerTab     ): @"Teilnehmer",
                    @(ReferentenTab     ): @"Referenten",
                    @(AustellerTab      ): @"Austeller",
                    @(KolloquiumTab     ): @"Kolloquium",
                    @(WerttbewerbTab    ): @"Werttbewerb",
                    @(FinalistenTab     ): @"Finalisten",
                    @(FraunhoferIPTTab  ): @"Fraunhofer",
                    @(WzlTab            ): @"WZL",
                    @(PartnerTab        ): @"Partner",
                    @(AachenTab         ): @"Aachen",
                    @(FotosTab          ): @"Fotos",
                    @(AktualisierenTab  ): @"Aktualisieren",
                    @(EventTabcount     ): @"EventCount",
                    @(ImpressumTab      ): @"Impressum",
                    @(LogoutTab         ): @"Logout"
                };
        
        IconTab = @{
                    @(ProgrammTab):       @"ic_action_schedule.png",
                    @(TeilnehmerTab ):    @"ic_participants.png",
                    @(ReferentenTab ):    @"ic_action_participants.png",
                    @(AustellerTab ):     @"ic_star.png",
                    @(KolloquiumTab ):    @"ic_launcher.png",
                    @(WerttbewerbTab ):   @"ic_competition.png",
                    @(FinalistenTab ):    @"ic_finalists.png",
                    @(FraunhoferIPTTab ): @"ic_ipt.jpg",
                    @(WzlTab ):           @"ic_wzl.png",
                    @(PartnerTab ):       @"ic_partners.png",
                    @(AachenTab ):        @"ic_aachen.png",
                    @(FotosTab ):         @"ic_action_fotos.png",
                    @(AktualisierenTab ): @"ic_refresh.png",
                    @(ImpressumTab):      @"ic_impressum.png",
                    @(LogoutTab):         @"ic_logout.png",
                };
        LayoutView = @{
                       @(ProgrammTab)  : [LayoutSetup withTableViewAndWith:ProgrammCellLayout
                                                          andDetailsView:ProgrammDetailsLayout
                                                                   title:@"Programm"
                                                                  source:@"activities"],
                       @(TeilnehmerTab): [LayoutSetup withTableViewAndWith:TeilnehmerCellLayout
                                                          andDetailsView:TeilnehmerDetailsLayout
                                                                   title:@"Teilnehmer"
                                                                  source:@"participants"],
                       @(ReferentenTab): [LayoutSetup withTableViewAndWith:ReferentenCellLayout
                                                            andDetailsView:TeilnehmerDetailsLayout
                                                                     title:@"Referenten"
                                                                    source:@"speakers"],
                       @(WzlTab): [LayoutSetup withTableViewAndWith:ReferentenCellLayout
                                                            andDetailsView:TeilnehmerDetailsLayout
                                                                     title:@"WZL"
                                                                    source:@"organizers.1.departments"],
                       @(FraunhoferIPTTab): [LayoutSetup withTableViewAndWith:InstituteCellLayout
                                                            andDetailsView:TeilnehmerDetailsLayout
                                                                     title:@"Fraunhofer IPT"
                                                                    source:@"organizers.0.departments"],
                       
//                    @(ReferentenTab ):    @"ic_action_participants.png",
//                    @(AustellerTab ):     @"ic_star.png",
//                    @(KolloquiumTab ):    @"ic_launcher.png",
//                    @(WerttbewerbTab ):   @"ic_competition.png",
//                    @(FinalistenTab ):    @"ic_finalists.png",
//                    @(FraunhoferIPTTab ): @"ic_ipt.jpg",
//                    @(WzlTab ):           @"ic_wzl.png",
//                    @(PartnerTab ):       @"ic_partners.png",
//                    @(AachenTab ):        @"ic_aachen.png",
//                    @(FotosTab ):         @"ic_action_fotos.png",
//                    @(AktualisierenTab ): @"ic_refresh.png",
//                    @(ImpressumTab):      @"ic_impressum.png",
//                    @(LogoutTab):         @"ic_logout.png",
                    };
    }

    return self;
}


-(int)getIdEvent{
    
    return 1;
    
}

-(NSDictionary *)getTabsEvent{
    
    

    return @{ @"Event":@[
                        @(ProgrammTab),
                        @(TeilnehmerTab),
                        @(ReferentenTab),
                        @(AustellerTab),
                        @(KolloquiumTab),
                        @(WerttbewerbTab),
                        @(FinalistenTab),
                      ],
              
              @"Veranstalter": @[
                      @(FraunhoferIPTTab),
                      @(WzlTab),
                      @(PartnerTab)
                    ],
              
              @"Allgeimenes":@[
                      @(AachenTab),
                      @(FotosTab),
                      @(AktualisierenTab),
                      @(ImpressumTab),
                      @(LogoutTab),
                      ],
            
              };
            
}

-(NSString *)getTitleOfTab:(long)tab{

    return [TitleTab objectForKey:@(tab)];

}

-(UIImage *)getIconOfTab:(long)tab{

    @try {
        
        return [UIImage imageNamed:[IconTab objectForKey:@(tab)]];
    }
    @catch (NSException *exception) {
    
        return [UIImage imageNamed:[IconTab objectForKey:@(ProgrammTab)]];
    
    }

}

-(Layout *) tableViewLayout{

    return [LayoutView objectForKey:@(actualTab)];
    
}


-(UIViewController *)getViewControllerOfTab:(long)tab{

    actualTab = tab;
    UIStoryboard *mystoryboard;
    mystoryboard = [UIStoryboard storyboardWithName:@"JahrestreffenDer_Storyboard" bundle:nil];
    KQNavigationController *nav = [mystoryboard instantiateViewControllerWithIdentifier:
                                   [[self tableViewLayout] getFirstViewControllerIdentifier]];
    
    KQTableViewController *tablewViewController = (KQTableViewController *)[nav topViewController];
    tablewViewController.delegate = self;
    
    return  nav;


}


@end