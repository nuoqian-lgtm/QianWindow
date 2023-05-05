#include "frameless.h"
#include <QDebug>
#include <QCoreApplication>

FramelessWindow::FramelessWindow(QWindow *parent)
    : QQuickWindow (parent),
      m_resizable(true),
      m_event(Mouse_None)
{
     setFlags(Qt::Window | Qt::FramelessWindowHint);
     QCoreApplication::instance()->installEventFilter(this); // 给自己加事件过滤器,用来实现拖动窗口


     m_monitorKeys.clear();
     foreach(const auto& key, m_monitorKeysList) {
         m_monitorKeys[key._key] = key;
     }

}

bool FramelessWindow::maximized()
{
    return windowStates() == Qt::WindowMaximized ? true : false;
}

void FramelessWindow::setMaximized(bool max)
{
    if (!max)
        showNormal();
    else
        showMaximized();
    emit maximizedChanged();
    emit resizeUpdate(this->size());
}

bool FramelessWindow::eventFilter(QObject *obj, QEvent *evt)
{
    QMouseEvent *mouse =  dynamic_cast<QMouseEvent *>(evt);

    if(m_event != Mouse_None && evt->type() == QEvent::WindowStateChange) {
        unsetCursor();
        m_event = Mouse_None;
    } else if(obj == this && mouse && windowStates() != Qt::WindowMaximized) {
        if(mouse->button() == Qt::LeftButton && mouse->type() == QEvent::MouseButtonPress) {   //按下
            m_globalPressPos = mouse->globalPos();
            m_pressPos = position();
            m_preSize = size();
            setCursorEvent(getMousePressEvent(mouse->pos()));
        } else if (m_event != Mouse_None && mouse->buttons() == Qt::LeftButton &&
                   mouse->type() == QEvent::MouseMove) {
            if (m_event == Mouse_Move) {            // 按下鼠标移动中
                setPosition(m_pressPos  + mouse->globalPos() - m_globalPressPos);
            } else if (m_event != Mouse_Move && m_resizable) {
                setCursorEvent(m_event);            // 按下鼠标设置窗口大小中
                setWindowGeometry(mouse->globalPos());
            }
        } else if(m_event != Mouse_None && mouse->button() == Qt::LeftButton && mouse->type() ==QEvent::MouseButtonRelease) {
            unsetCursor();
            m_event = Mouse_None;
        } else if (m_event == Mouse_None && mouse->type() == QEvent::MouseMove) {       // 鼠标徘徊
            MouseEvent currentEven = getResizeArea(mouse->pos());
                setCursorEvent(currentEven, false);
        }
    } else if (m_monitorEnable  && evt->type() == QEvent::KeyRelease) {
        checkMonitorKeys(obj, evt);
    }

    return QQuickWindow::eventFilter(obj,evt);
}


FramelessWindow::MouseEvent FramelessWindow::getMousePressEvent(const QPoint &pos)
{
    int x = pos.x();
    int y = pos.y();
    int w = width();
    int h = height();
    int i;

    if (x <= 8 && y <= 8) {
        return Mouse_TopLeft;
    } else if (x >=(w - 8) && y <= 8) {
        return Mouse_TopRight;
    } else if (x <= 8 && y >= (h - 8)) {
        return Mouse_BottomLeft;
    } else if (x >=(w - 8)  && y >= (h - 8)) {
        return Mouse_BottomRight;
    } else if (y <= 8) {
        return Mouse_Top;
    } else if (x <= 8 ) {
        return Mouse_Left;
    } else if (x >=(w - 8) ) {
        return Mouse_Right;
    }  else if (y >= (h - 8)) {
        return Mouse_Bottom;
    }   else {
        for (i = 0; i < m_moveArea.length(); i ++) {
            if (m_moveArea[i].contains(x, y))
               return Mouse_Move;
        }
        return Mouse_None;
    }
}

FramelessWindow::MouseEvent FramelessWindow::getResizeArea(const QPoint &pos)
{
    int x = pos.x();
    int y = pos.y();
    int w = width();
    int h = height();

    if (x <= 8 && y <= 8) {
        return Mouse_TopLeft;
    } else if (x >=(w - 8) && y <= 8) {
        return Mouse_TopRight;
    } else if (x <= 8 && y >= (h - 8)) {
        return Mouse_BottomLeft;
    } else if (x >=(w - 8)  && y >= (h - 8)) {
        return Mouse_BottomRight;
    } else if (y <= 8) {
        return Mouse_Top;
    } else if (x <= 8 ) {
        return Mouse_Left;
    } else if (x >=(w - 8) ) {
        return Mouse_Right;
    }  else if (y >= (h - 8)) {
        return Mouse_Bottom;
    }   else {
        return Mouse_None;
    }
}

// 改变大小
void FramelessWindow::setWindowGeometry(const QPoint &pos)
{
    QPoint offset = m_globalPressPos - pos;

    if (m_globalPressPos == pos)
        return;


    switch (m_event) {
    case Mouse_TopLeft:
        setGeometryCalc(m_preSize + QSize(offset.x(), offset.y()), m_pressPos - offset);
        break;
    case Mouse_Top:
        setGeometryCalc(m_preSize + QSize(0, offset.y()), m_pressPos - QPoint(0, offset.y()));
        break;
    case Mouse_TopRight:
        setGeometryCalc(m_preSize - QSize(offset.x(), -offset.y()), m_pressPos - QPoint(0, offset.y()));
        break;
    case Mouse_Left:
        setGeometryCalc(m_preSize + QSize(offset.x(), 0), m_pressPos - QPoint(offset.x(), 0));;
        break;
    case Mouse_Right:
        setGeometryCalc(m_preSize - QSize(offset.x(), 0), position());
        break;
    case Mouse_BottomLeft:
        setGeometryCalc(m_preSize + QSize(offset.x(), -offset.y()), m_pressPos - QPoint(offset.x(), 0));
        break;
    case Mouse_Bottom:
        setGeometryCalc(m_preSize + QSize(0, -offset.y()), position());
        break;
    case Mouse_BottomRight:
        setGeometryCalc(m_preSize - QSize(offset.x(), offset.y()), position());
        break;
    default:
        break;
    }

}

void FramelessWindow::setGeometryCalc(const QSize &size, const QPoint &pos)
{
    QPoint endPos = m_pressPos;
    QSize endSize = minimumSize();
    if (size.width() > minimumWidth()) {
        endPos.setX(pos.x());
        endSize.setWidth(size.width());
    } else if (pos.x() != endPos.x()) {
        endPos.setX(m_pressPos.x() +  m_preSize.width() - minimumWidth());
    }

    if (size.height() > minimumHeight()) {
        endPos.setY(pos.y());
        endSize.setHeight(size.height());
    } else if (pos.y() != endPos.y()) {
        endPos.setY(m_pressPos.y() + m_preSize.height() - minimumHeight());
    }
    setGeometry(QRect(endPos, endSize));
    emit resizeUpdate(endSize);

}


void FramelessWindow::setCursorDrag(bool dragging)
{
    setCursor(dragging ? Qt::OpenHandCursor : Qt::ArrowCursor);
}


void FramelessWindow::setCursorEvent(MouseEvent event, bool isRefrensh)
{

    switch (event) {
    case Mouse_TopLeft:
    case Mouse_BottomRight:
        setCursor(Qt::SizeFDiagCursor);
        break;
    case Mouse_Top:
    case Mouse_Bottom:
        setCursor(Qt::SizeVerCursor);
        break;
    case Mouse_TopRight:
    case Mouse_BottomLeft:
        setCursor(Qt::SizeBDiagCursor);
        break;
    case Mouse_Left:
    case Mouse_Right:
        setCursor(Qt::SizeHorCursor);
        break;
    default :
        if(m_event != event)
            unsetCursor();
        break;
    }
    if(isRefrensh)
        m_event = event;
}


void FramelessWindow::checkMonitorKeys(QObject *obj, QEvent *evt)
{

    QKeyEvent *key =  dynamic_cast<QKeyEvent *>(evt);
    if(!key) return;

    if(m_monitorKeys.contains((Qt::Key)key->key()) && obj == this) {

       bool modifiersCtrl = m_monitorKeys[(Qt::Key)key->key()]._modifiersCtrl;

       if(!modifiersCtrl && key->modifiers() == Qt::NoModifier) {
           emit monitorKeyPress((Qt::Key)key->key());

       } else if(modifiersCtrl && key->modifiers() == Qt::ControlModifier) {
           emit monitorKeyPress((Qt::Key)key->key());

       }
    }

}
