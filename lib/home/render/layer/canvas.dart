import 'dart:async';
import 'dart:math';
import 'dart:ui';

void main() {
  Timer.periodic(Duration(seconds: 3), (timer) {
    drawRandomPoint();
    print('window.scheduleFrame');
    window.scheduleFrame();
  });
}

void drawRandomPoint() {
  PictureRecorder recorder = PictureRecorder();
  Canvas canvas = Canvas(recorder);

  Paint p = Paint();
  p.strokeWidth = 30.0;
  p.color = Color(0xFFFF00FF);

//  canvas.drawLine(Offset(300, 300), Offset(800, 800), p);
  var dx = Random().nextInt(800).toDouble();
  var dy = Random().nextInt(800).toDouble();
  canvas.drawCircle(Offset(dx, dy), 30, p);

  Picture picture = recorder.endRecording();

  SceneBuilder sceneBuilder = SceneBuilder();
  sceneBuilder.pushOffset(0, 0);
  sceneBuilder.addPicture(new Offset(0, 0), picture);
  sceneBuilder.pop();
  Scene scene = sceneBuilder.build();

  window.onDrawFrame = () {
    print('onDrawFrame');
    window.render(scene);
  };

  window.onBeginFrame = (Duration duration) {
    print('on Begin Frame');
  };
}
