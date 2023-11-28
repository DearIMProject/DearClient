//
//  MYMessageEnum.h
//  DearIMProject
//
//  Created by APPLE on 2023/11/6.
//

#ifndef MYMessageEnum_h
#define MYMessageEnum_h

typedef enum : int {
    MYMessageEntiteyType_USER = 0,
    MYMessageEntiteyType_GROUP,
    MYMessageEntiteyType_SERVER,
    MYMessageEntityType_ALL
} MYMessageEntityType;

typedef enum : int {
    MYMessageType_TEXT = 0,
    MYMessageType_PICTURE,
    MYMessageType_FILE,
    MYMessageType_LINK,
    MYMessageType_CHAT_MESSAGE,
    MYMessageType_REQUEST_LOGIN,
    MYMessageType_REQUEST_HEART_BEAT,
    MYMessageType_REQUEST_OFFLINE_MSGS,
    MYMessageType_READED_MESSAGE,
    MYMessageType_ALL
} MYMessageType;

typedef enum : int {
    MYMessageSerializeType_JSON = 0,
    MYMessageSerializeType_XML,
    MYMessageSerializeType_ALL
} MYMessageSerializeType;


#endif /* MYMessageEnum_h */
