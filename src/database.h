#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QSqlDatabase>
#include <QList>
#include <QTimer>

#include "song.h"

class Database : public QObject
{
    Q_OBJECT
public:
    explicit Database(QObject *parent = 0);

    void addPlaylistItem(Song* song);
    QList<Song*> getPlaylistItems();

    void delayCommitTimerTimeout();

private:
    QString m_fileName;
    QTimer *m_delayCommitTimer;

    void initDatabase();
    void initDelayCommitTimer();
};

#endif // DATABASE_H
