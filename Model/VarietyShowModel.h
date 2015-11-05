//
//  VarietyShowModel.h
//  FengXingPlayer
//
//  Created by 古玉彬 on 15/11/5.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import "JSONModel.h"

@interface VarietyShowModel : JSONModel
@property (copy, nonatomic) NSString *img;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *tinf;
@property (copy, nonatomic) NSString *vinf;
@end
