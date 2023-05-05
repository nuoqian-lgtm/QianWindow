.import QtQuick 2.0 as QQ


var ballData = [
            {
                "radius" : 125,
                "cor" : 0.2,
                "image" : "icon/ball1.png",
                "mergeImage" : "icon/merge2.png",
            },
            {
                "radius" : 115,
                "cor" : 0.3,
                "image" : "icon/ball2.png",
                "mergeImage" : "icon/merge3.png",
            },
            {
                "radius" : 105,
                "cor" : 0.3,
                "image" : "icon/ball3.png",
                "mergeImage" : "icon/merge4.png",
            },
            {
                "radius" : 95,
                "cor" : 0.3,
                "image" : "icon/ball4.png",
                "mergeImage" : "icon/merge5.png",
            },
            {
                "radius" : 80,
                "cor" : 0.3,
                "image" : "icon/ball5.png",
                "mergeImage" : "icon/merge6.png",
            },
            {
                "radius" : 70,
                "cor" : 0.3,
                "image" : "icon/ball6.png",
                "mergeImage" : "icon/merge7.png",
            },
            {
                "radius" : 60,
                "cor" : 0.3,
                "image" : "icon/ball7.png",
                "mergeImage" : "icon/merge8.png",
            },
            {
                "radius" : 50,
                "cor" : 0.3,
                "image" : "icon/ball8.png",
                "mergeImage" : "icon/merge9.png",
            },
            {
                "radius" : 40,
                "cor" : 0.3,
                "image" : "icon/ball9.png",
                "mergeImage" : "icon/merge10.png",
            },
            {
                "radius" : 30,
                "cor" : 0.3,
                "image" : "icon/ball10.png",
                "mergeImage" : "icon/merge11.png",
            },
            {
                "radius" : 20,
                "cor" : 0.1,
                "image" : "icon/ball11.png",
                "mergeImage" : "icon/merge11.png",
            },
];

var component;
var mergeComponent;
var balls = new Array(0);
var currentBall = null;


function getBallData() {

   if (balls.length < 3)        // 开场前3个都为葡萄
       return ballData.length - 1;

   else if (balls.length < 6)
       return Math.random() < 0.55 ? ballData.length - 1 :
              Math.random() < 0.55 ? ballData.length - 2 :
              Math.random() < 0.88 ? ballData.length - 3 :
              Math.random() < 0.77 ? ballData.length - 4 :
              Math.random() < 0.66 ? ballData.length - 5 : ballData.length - 6;

   else
       return Math.random() < 0.35 ? ballData.length - 1 :
              Math.random() < 0.25 ? ballData.length - 2 :
              Math.random() < 0.36 ? ballData.length - 3 :
              Math.random() < 0.40 ? ballData.length - 4 : ballData.length - 5;
}


function newBall(x) {
    if (component == null)
        component = Qt.createComponent("Ball.qml");

    if (component.status == QQ.Component.Ready) {
        let index = getBallData();

        if (x < ballData[index].radius) {
            x = ballData[index].radius
        } else if (x + ballData[index].radius > width) {
            x = width - ballData[index].radius
        }

        var dynamicObject = component.createObject(canvas,
                   { pointX: x,
                     pointY: ballData[index].radius,
                     r: ballData[index].radius,
                     cor: ballData[index].cor,
                     source: ballData[index].image,
                     mass: ballData[index].radius * ballData[index].radius,
                     ballType: index,
                     mergeSrc : ballData[index].mergeImage,
                   });
        dynamicObject.width = ballData[index].radius * 2;
        dynamicObject.height = ballData[index].radius * 2;
        currentBall = dynamicObject

    }
}


function currentBallMove(x) {
    if (currentBall == null) {
        return false;
    }
    if (x < currentBall.r || x + currentBall.r > width) {
        return false;
    }

    currentBall.pointX = x ;
    return true;
}

function currentBallStartDown() {
    if (currentBall == null) {
        return false;
    }


    if ( currentBall.shapeChange == true) {
        return false;
    }

    currentBall.vy = 10;
    balls[balls.length] = currentBall
    currentBall = null
    return true;
}

const edgeCorX = 0.2;
const edgeCorY = 0.2;
const ballAy = 1;
function ballsMove() {
    for (var i in balls) {
        var ball =  balls[i];


        ball.vy += ballAy;

        ball.preX  = ball.pointX
        ball.preY  = ball.pointY
        ball.pointX += ball.vx;
        ball.pointY += ball.vy;

        if (ball.pointX < ball.r) {
            ball.pointX = ball.r
            ball.vx = -ball.vx * edgeCorX
            if (Math.abs(ball.vx)<0.1)  ball.vx = 0

        } else if (ball.pointX + ball.r > width) {
            ball.pointX = width - ball.r
            ball.vx = -ball.vx * edgeCorX
            if (Math.abs(ball.vx)<0.1)  ball.vx = 0

        }

        if (ball.pointY < ball.r) {
            ball.pointY = ball.r
            ball.vy = -ball.vy * edgeCorY
        } else if (ball.pointY + ball.r > height) {
            ballIsDown(ball);
            ball.pointY = height - ball.r
            ball.vy = -ball.vy * edgeCorY
        }


    }
}



function collide() {

    for (let i = 0; i < balls.length; i++)  {
        let ball1 = balls[i]
       for (let j = i + 1; j < balls.length; j++) {
           let ball2 = balls[j]
           let distance = Math.sqrt(Math.pow((ball1.pointX - ball2.pointX),2) + Math.pow((ball1.pointY - ball2.pointY),2));
           let radius = ball1.r + ball2.r;

           if (distance > radius) continue;


           if (!ball1.mergeStart && !ball2.mergeStart && ball1.ballType == ball2.ballType && ball2.ballType > 0) {
               mergeBall(j,i);
               return;
           }
           else
               changeSpeedAndDirection(ball1, ball2, distance, radius);
        }
    }
}

function ballsRotate() {

    for (let i = 0; i < balls.length; i++)  {
       var ball = balls[i]
       if (ball.mergeStart) continue
       let distance = Math.sqrt(Math.pow((ball.pointX - ball.preX),2) + Math.pow((ball.pointY - ball.preY),2));

       if (Math.abs(distance)  && ball.vy < 10 ) {
           if (ball.vx > 0) {
               ball.rotation +=  360/(2 * ball.r * 3.14) * distance;
           }
           else {
              ball.rotation -=  360/(2 * ball.r * 3.14) * distance;
           }
           if (Math.abs(ball.vx) < 0.1)
               ball.vx = 0

       }
    }
}


function changeSpeedAndDirection(ball1, ball2, distance, radius) {


    if (distance < radius) {
        let dd = radius - distance;
        let offsetC = radius - distance;
        let ballOffsetX = (ball1.pointX - ball2.pointX) / radius * offsetC ;
        let ballOffsetY = Math.abs((ball1.pointY - ball2.pointY) / radius * offsetC);

        let ball1MassRation = ball2.mass / (ball1.mass+ball2.mass);
        let ball2MassRation = ball1.mass / (ball1.mass+ball2.mass);

        ball1.pointX += ballOffsetX * ball1MassRation;
        ball2.pointX -= ballOffsetX * ball2MassRation;
        if (ball1.pointY > ball2.pointY)  ball2.pointY -= ballOffsetY;
               else ball1.pointY -= ballOffsetY;

    }
    let dx = ball1.pointX - ball2.pointX
    let dy = ball1.pointY - ball2.pointY

    let ex = dx / radius; let ey = dy / radius;

    let v1n = ex * ball1.vx + ey * ball1.vy
    let v2n = ex * ball2.vx + ey * ball2.vy
    if(v1n >= v2n) return;
    let v1nn = ball1.cor * ((ball1.mass - ball2.mass) * v1n + 2 *ball2.mass *v2n ) / (ball1.mass +ball2.mass)
    let v2nn = ball2.cor * ((ball2.mass - ball1.mass) * v2n + 2 *ball1.mass *v1n ) / (ball1.mass +ball2.mass)

    let ux = -dy / radius; let uy = dx / radius;
    let v1t =ux * ball1.vx + uy*ball1.vy
    let v2t = ux * ball2.vx + uy * ball2.vy

    ball1.vx = v1nn*ex +v1t*ux;
    ball1.vy = v1nn*ex +v1t*uy;

    ball2.vx = v2nn*ex +v2t*ux;
    ball2.vy = v2nn*ex +v2t*uy;


    if (v1n == 0 && v1t ==0 && v2t == 0) {
        ball2.vx += 0.1
        ball2.vy += 0.3
    }

}

function mergeBall(i, j) {
    let ball1 = balls[i]
    let ball2 = balls[j]



    ball1.endPointX = ball1.pointX + (ball2.pointX - ball1.pointX) / 2
    ball1.endPointY = ball1.pointY + (ball2.pointY - ball1.pointY) / 2

    if (ball1.vy > 10)
        ball1.vy = 0

    if (ball1.endPointX < ball1.r) {
        ball1.endPointX = ball1.r
    } else if (ball1.endPointX + ball1.r > width) {
        ball1.endPointX = width - ball1.r
    }

    if (ball1.endPointY < ball1.r) {
        ball1.endPointY = ball1.r
    } else if (ball1.endPointY + ball1.r > height) {
        ball1.endPointY = height - ball.r
    }

    ball2.destroy();
    balls[j] = null;
    balls.splice(j, 1);

    score += (ballData.length - ball1.ballType) * 2
    ball1.ballType -= 1
    ball1.mergeSrc = ballData[ball1.ballType].mergeImage;

    ball1.r = ballData[ball1.ballType].radius
    ball1.cor = ballData[ball1.ballType].cor
    ball1.mass = ball1.r * ball1.r
    ball1.source = ballData[ball1.ballType].image
    ball1.width = ball1.r * 2;
    ball1.height = ball1.r * 2;
    ball1.vx = 0
    ball1.vy = 0

    ball1.mergeStart = true

    newMergeAnimal(ball1.endPointX,ball1.endPointY,ball1.r,ballData[ball1.ballType].mergeImage);
}


function ballOverflow() {

    for (var i in balls)  {
        let ball = balls[i]
        if (!ball.mergeStart && Math.abs(ball.vy) < 0.3 && Math.abs(ball.vx) < 0.3 && (ball.y < lineDashY)) {

            if (currentBall != null) {
                balls[balls.length] = currentBall
                currentBall = null
            }
            return true
        }
    }
    return false
}

function ballCloseAnimal() {

    var minY = 999999
    var index = -1

    for (var i in balls)  {
        if (balls[i].pointY < minY) {
            minY = balls[i].pointY
            index = i
        }
    }

    if (index >= 0) {
        let image = balls[index].ballType > 0 ? balls[index].ballType -1 : balls[index].ballType

        newMergeAnimal(balls[index].pointX,
                       balls[index].pointY,
                       balls[index].r,
                       ballData[image].mergeImage);

        balls[index].destroy();
        balls[index] = null;
        balls.splice(index, 1);
    }
    return index
}


function process() {

    if (!finish) {
        ballsMove();
        collide();
        ballsRotate();
        if (ballOverflow()) {
            finish = 1
        }
    }
    else if (finish == 1) {
        let date = new Date;
        let totalMs = date - preBallLeaveDate;

        if (totalMs > 60) {
            if (ballCloseAnimal() >= 0) {
                preBallLeaveDate = date
            } else {
                finish = 2
                finishSound.play()

            }
        }
    }
}


function newMergeAnimal(pointX, pointY, radius, image) {

    if (mergeComponent == null)
        mergeComponent = Qt.createComponent("MergeAnimal.qml");

    if (mergeComponent.status == QQ.Component.Ready) {

       var dynamicMerge = mergeComponent.createObject(canvas,
                   { x: pointX - radius * 1.3,
                     y: pointY - radius * 1.3,
                     width: radius * 2.6,
                     height: radius * 2.6,
                     mergeSrc: image,
                   });

    } else {
        console.log("error loading block component");
        return false;
    }

    mergeSound1.play()
    mergeSound2.play()
    return true;
}

function ballIsDown(ball) {
    if (ball.vy > 30)
        downSound.play();
}


