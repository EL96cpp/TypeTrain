#include "txtreader.h"

TxtReader::TxtReader(QObject *parent)
    : QObject{parent}
{

}

void TxtReader::readTxtFile(const QString& language, const QString &file_title)
{

    qDebug() << "reading file " << file_title;

    QString file_path = ":/Texts/" + QString(file_title.at(0)) + ".txt";
    QFile file(file_path);

    if (!file.open(QIODevice::ReadOnly)) {

        qDebug() << file.errorString();
        emit openTxtError(file_path);
        return;

    }

    QTextStream in(&file);
    QString lesson_text;
    lesson_text.clear();

    while(!in.atEnd()) {

        QString line = in.readLine();
        lesson_text += line;

    }

    file.close();
    emit returnTextToQML(language, lesson_text);


}
