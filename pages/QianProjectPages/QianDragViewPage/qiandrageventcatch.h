#ifndef QianDragEventCatch_H
#define QianDragEventCatch_H

#include <QObject>

class QianDragEventCatch : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QObject* container READ container WRITE setContainer NOTIFY containerChanged)
    Q_PROPERTY(QObject* filterObj READ filterObj WRITE setFilterObj NOTIFY filterObjChanged)

    Q_PROPERTY(bool catchEnable MEMBER _catchEnable NOTIFY catchEnableChanged)
signals:
    void containerChanged();
    void filterObjChanged();
    void catchEnableChanged();

public:
    explicit QianDragEventCatch(QObject *parent = nullptr);
    ~QianDragEventCatch();

    QObject *container() { return _container; }
    void setContainer(QObject *container);

    QObject *filterObj() { return  _filterObj; }
    void setFilterObj(QObject *container);


    bool eventFilter(QObject *obj, QEvent *evt);


signals:
    void released(int mouseX, int mouseY);
    void pressed(int mouseX, int mouseY);
    void moved(int mouseX, int mouseY);

protected:

    QObject *_container{nullptr};
    QObject *_filterObj{nullptr};
    bool _catchEnable{true};
};

#endif // QianDragEventCatch_H
