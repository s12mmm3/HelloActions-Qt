﻿#ifndef CONFIG_H
#define CONFIG_H
#include <QObject>
#include <QVariantMap>
namespace Config{

static QString anonymous_token = "de91e1f8119d32e01cc73efcb82c0a30c9137e8d4f88dbf5e3d7bf3f28998f21add2bc8204eeee5e56c0bbb8743574b46ca2c10c35dc172199bef9bf4d60ecdeab066bb4dc737d1c3324751bcc9aaf44c3061cd18d77b7a0";
static QVariantMap resourceTypeMap = {
    { "0", "R_SO_4_" },
    { "1", "R_MV_5_" },
    { "2", "A_PL_0_" },
    { "3", "R_AL_3_" },
    { "4", "A_DJ_1_" },
    { "5", "R_VI_62_"},
    { "6", "A_EV_2_" },
    { "7", "A_DR_14_"}
};
}
#endif // CONFIG_H
