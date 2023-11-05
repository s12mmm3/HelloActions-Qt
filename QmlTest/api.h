#ifndef API_H
#define API_H

#include <QObject>

#include "../QCloudMusicApi/module.h"

class Api : public QObject
{
    Q_OBJECT
public:
    explicit Api(QObject *parent = nullptr);
    Q_INVOKABLE QVariantMap invoke(QString funName, QVariantMap arg);

private:
    QString cookie = "";
    NeteaseCloudMusicApi api;
signals:

};

#endif // API_H
