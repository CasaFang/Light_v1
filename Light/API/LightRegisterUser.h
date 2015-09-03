//
//  LightRegisterUser.h
//  
//
//  Created by FLY on 15/6/14.
//
//

#import <Foundation/Foundation.h>

@interface LightRegisterUser : NSObject

@property (nonatomic,readwrite,assign) NSString *userID;
@property (nonatomic,readwrite,copy) NSString *code;
@property (nonatomic,readwrite,copy) NSString *pwd;
@property (nonatomic,readwrite,copy) NSString *name;
@property (nonatomic,readwrite,copy) NSString *physiology_gender;
@property (nonatomic,readwrite,copy) NSString *society_gender;

@end
