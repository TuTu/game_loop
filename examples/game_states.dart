import 'dart:html';
import 'package:game_loop/game_loop_html.dart';

GameLoopHtml gameLoop;
CanvasRenderingContext2D canvas;

// Create a simple state which no custom methods or state properties
GameLoopHtmlState initial_state =
  new GameLoopHtmlState(
      onRender: (GameLoopHtml loop) {
        print("Render initial_state");
        canvas.clearRect(0, 0, 640, 480);
        canvas.strokeText("Initial State", 0, 100);
      },
      onKeyDown: (KeyboardEvent event) {
        print("Key event");
        print("Switching to $custom_state_1");
        print("Rendering with ${custom_state_1.onRender}}");
        gameLoop.setState(custom_state_1);
      });

// Create a CustomState class with unique state properties
//
// Subclassing GameLoopState allows you to organise the state of your game
// without poluting the global state.
class CustomState extends GameLoopHtmlState {
  String name;
  GameLoopHtmlState nextState;
  
  CustomState(this.name, this.nextState) {
    onRender = (GameLoopHtml loop) {
      print("Render $name");
      canvas.clearRect(0, 0, 640, 480);
      canvas.strokeText(name, 0, 100);
      
      _renderSquare();
    };
    onKeyDown = (KeyboardEvent event) {
      print("Key event");
      gameLoop.setState(nextState);
    };
  }
  
  _renderSquare() {
    canvas.fillRect(0, 0, 20, 20);
  }
}

CustomState custom_state_1 = new CustomState("Custom State 1", custom_state_2);
CustomState custom_state_2 = new CustomState("Custom State 2", initial_state);

main() {
  CanvasElement element = querySelector(".game-element");
  gameLoop = new GameLoopHtml(element);
  canvas = element.context2D;
  
  gameLoop.setState(initial_state);
  
  gameLoop.start();
}