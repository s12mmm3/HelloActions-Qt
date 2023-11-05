#include <iostream>
#include <QObject>
#include <QDebug>

#include "../CApi/capi.h"
int main(int argc, char *argv[]) {
    qDebug() << getFunCount();
}
