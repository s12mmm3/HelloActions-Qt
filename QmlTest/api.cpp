#include "api.h"

Api::Api(QObject *parent)
    : QObject{parent}
{

}

QVariantMap Api::invoke(QString funName, QVariantMap arg) {
    arg["cookie"] = arg.value("cookie", cookie);
    cookie = arg["cookie"].toString() + " SameSite=None; Secure";
    QVariantMap ret;
    QMetaObject::invokeMethod(&api, funName.toUtf8(),
                              Qt::DirectConnection,
                              Q_RETURN_ARG(QVariantMap, ret),
                              Q_ARG(QVariantMap, arg));
    return ret;
}
