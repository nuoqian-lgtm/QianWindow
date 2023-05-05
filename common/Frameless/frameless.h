#ifndef FRAMELESSWINDOW_H
#define FRAMELESSWINDOW_H

#include <QQuickWindow>
#include <QQuickItem>
#include <QSize>
#include <QList>


class MonitorKey
{
public:
    MonitorKey() {}

    MonitorKey (Qt::Key key, bool  modifiersCtrl) : _key(key), _modifiersCtrl(modifiersCtrl)
    { }

    Qt::Key _key;
    bool    _modifiersCtrl;

};


class FramelessWindow : public QQuickWindow
{
    Q_OBJECT
    Q_PROPERTY(bool monitorEnable MEMBER m_monitorEnable)
    Q_PROPERTY(bool resizable MEMBER m_resizable)
    Q_PROPERTY(QList<QRect> moveArea MEMBER m_moveArea)
    Q_PROPERTY(bool maximized READ maximized WRITE setMaximized NOTIFY maximizedChanged)

    enum MouseEvent {
        Mouse_None  = 0,
        Mouse_Pressed ,
        Mouse_TopLeft ,
        Mouse_Top,
        Mouse_TopRight,
        Mouse_Left,
        Mouse_Move,
        Mouse_Right,
        Mouse_BottomLeft,
        Mouse_Bottom,
        Mouse_BottomRight,
    };

public:
    explicit FramelessWindow(QWindow *parent = nullptr);
    bool maximized();
    void setMaximized(bool max);

    Q_INVOKABLE void setCursorDrag(bool dragging);

protected:
    bool eventFilter(QObject *obj, QEvent *evt) override;

    void checkMonitorKeys(QObject *obj, QEvent *evt);

signals:
    void resizeUpdate(QSize size);
    void maximizedChanged();
    void monitorKeyPress(Qt::Key key);

private:
    MouseEvent getMousePressEvent(const QPoint &pos);
    MouseEvent getResizeArea(const QPoint &pos);
    void setWindowGeometry(const QPoint &pos);
    void setCursorEvent(MouseEvent event, bool isRefrensh = true);
    void setGeometryCalc(const QSize &size, const QPoint &pos);

    bool m_resizable;
    MouseEvent m_event;
    QPoint m_globalPressPos;    // 鼠标按下的全局坐标
    QPoint m_pressPos;          // 鼠标按下的应用程序内的坐标
    bool m_move;
    QSize  m_preSize;
    QList<QRect> m_moveArea;

    bool m_monitorEnable{true};

    QList<MonitorKey> m_monitorKeysList{};
    QHash<Qt::Key, MonitorKey> m_monitorKeys;
};

#endif
