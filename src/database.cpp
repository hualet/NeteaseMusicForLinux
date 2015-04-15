#include "database.h"

#include <QDir>
#include <QFile>
#include <QSqlQuery>
#include <QVariant>

Database::Database(QObject *parent) :
    QObject(parent)
{
    QString configDir = QDir::home().filePath(".config");
    QDir(configDir).mkdir("NeteaseMusicForLinux");
    QString appConfigDir = QDir(configDir).filePath("NeteaseMusicForLinux");
    m_fileName = QDir(appConfigDir).filePath("playlist.db");

    QFile file(m_fileName);
    if (!file.exists()) {
        file.open(QFile::WriteOnly);
        file.close();

        initDatabase();
    }
}

void Database::initDatabase()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(m_fileName);
    db.open();

    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS PLAYLIST ("
               "ID CHAR PRIMARY KEY,"
               "NAME CHAR,"
               "ARTIST CHAR,"
               "ALBUM CHAR,"
               "MP3URL CHAR,"
               "PICURL CHAR,"
               "DURATION LONG)");
    db.close();
}

void Database::addPlaylistItem(Song *song)
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(m_fileName);
    db.open();

    QSqlQuery query;
    query.prepare("INSERT INTO PLAYLIST (ID, NAME, ARTIST, ALBUM, MP3URL, PICURL, DURATION)"
                  "VALUES (?, ?, ?, ?, ?, ?, ?)");
    query.addBindValue(song->id());
    query.addBindValue(song->name());
    query.addBindValue(song->artist());
    query.addBindValue(song->album());
    query.addBindValue(song->mp3Url());
    query.addBindValue(song->picUrl());
    query.addBindValue(song->duration());
    query.exec();

    db.close();
}

QList<Song*> Database::getPlaylistItems()
{
    QList<Song*> list;
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(m_fileName);
    db.open();

    QSqlQuery query("SELECT * FROM PLAYLIST");
    while (query.next()) {
        QString id = query.value(0).toString();
        QString name = query.value(1).toString();
        QString artist = query.value(2).toString();
        QString album = query.value(3).toString();
        QString mp3Url = query.value(4).toString();
        QString picUrl = query.value(5).toString();
        int duration = query.value(6).toInt();

        Song *song = new Song(id, name, mp3Url, picUrl,
                              artist, album, duration, this);
        list << song;
    }

    db.close();

    return list;
}
