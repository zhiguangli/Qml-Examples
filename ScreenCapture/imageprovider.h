#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QQuickImageProvider>
#include <QImage>
#include <QPixmap>

class ImageProvider : public QQuickImageProvider
{

public:
    explicit ImageProvider(ImageType type, Flags flags = 0);

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;
    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize) override;

    void setImage(QImage image);
private:
    QImage image;
};

#endif // IMAGEPROVIDER_H
