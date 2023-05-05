#include "Backed.h"
#include <QFile>
#include <QDebug>
#include <QCoreApplication>
#include <QGuiApplication>
#include <QFileInfo>
#include <QDir>

Backed* Backed::m_instance = NULL;
//-----------------------------------------------------------------------------
Backed::Backed( QObject *parent)
    : QObject(parent)
{


}




bool Backed::saveFile(QString path, const QString& data)
{


    QFile file(path.remove("file:///"));

    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qWarning()<<"Backed::saveFile err:"<<path;
        emit errorMessage("写入文件内容失败,请检查文件是否已被其它应用程序打开!");
        return false;
    }

    file.write(data.toUtf8());
    file.close();
    return  true;
}

QString Backed::importFile(QString path)
{
#ifdef Q_OS_WINDOWS
    path = path.remove("file:///").remove("qrc");
#else
    path = path.remove("file://").remove("qrc");
#endif

    QString appPath = QCoreApplication::applicationDirPath();

    QFile file(path);

    if(!QFile::exists(path)) {
        return "";
    }
    qDebug()<<"QFileInfo(QFile)."<<path <<QFileInfo(path).fileName();
    QString newPath = appPath + "/" + QFileInfo(path).fileName();
    if(QFile::exists(newPath)) {
        QFile::remove(newPath);
    }

    return file.copy(newPath) ? newPath : "";
}

bool Backed::copyFile(QString path, QString newPath)
{
#ifdef Q_OS_WINDOWS
    path = path.remove("file:///").remove("qrc");
#else
    path = path.remove("file://").remove("qrc");
#endif



    QFile file(path);

    if(!QFile::exists(path)) {
        return false;
    }

    if(QFile::exists(newPath)) {
        QFile::remove(newPath);
    }

    return file.copy(newPath);
}

bool Backed::fileExists(QString path)
{
    return  QFile::exists(path);
}



