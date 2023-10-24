#ifndef TXTREADER_H
#define TXTREADER_H

#include <QObject>
#include <QFile>
#include <QTextStream>
#include <QDebug>

class TxtReader : public QObject
{
    Q_OBJECT
public:
    explicit TxtReader(QObject *parent = nullptr);

public slots:
    void readTxtFile(const QString& language, const QString& file_title);


signals:
    void returnTextToQML(const QString& language, const QString& lesson_text);
    void openTxtError(const QString& file_path);

};

#endif // TXTREADER_H
