import 'dart:html';
import 'package:game_loop/game_loop_html.dart';

GameLoopHtml gameLoop;
CanvasRenderingContext2D canvas;

class CustomState extends GameLoopHtmlState {
  CustomState() :
    super(onRender: (GameLoopHtml loop) {
      print("Render CustomState");
      canvas.clearRect(0, 0, 640, 480);
      canvas.strokeText("Custom State", 0, 100);
    },
    onKeyDown: (KeyboardEvent event) {
      print("Key event");
      gameLoop.setState(initial_state);
    });
}

CustomState custom_state = new CustomState();

GameLoopHtmlState initial_state =
  new GameLoopHtmlState(
      onRender: (GameLoopHtml loop) {
        print("Render initial_state");
        canvas.clearRect(0, 0, 640, 480);
        canvas.strokeText("Initial State", 0, 100);
      },
      onKeyDown: (KeyboardEvent event) {
        print("Key event");
        print("Switching to $custom_state");
        print("Rendering with ${custom_state.onRender}}");
        gameLoop.setState(custom_state);
      });

main() {
  CanvasElement element = querySelector(".game-element");
  gameLoop = new GameLoopHtml(element);
  canvas = element.context2D;
  
  gameLoop.setState(initial_state);
  
  gameLoop.start();
}