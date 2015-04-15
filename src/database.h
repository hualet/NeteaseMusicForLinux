#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QSqlDatabase>
#include <QList>

#include "song.h"

class Database : public QObject
{
    Q_OBJECT
public:
    explicit Database(QObject *parent = 0);

    void addPlaylistItem(Song* song);
    QList<Song*> getPlaylistItems();

private:
    QString m_fileName;

    void initDatabase();
};

#endif // DATABASE_H
