import 'dart:html';
import 'package:game_loop/game_loop_html.dart';

GameLoopHtml gameLoop;
CanvasRenderingContext2D canvas;

const int WIDTH = 640;
const int HEIGHT = 480;

drawText(CanvasRenderingContext2D canvas, String text) {
  canvas.clearRect(0, 0, WIDTH, HEIGHT);
  canvas.font = "italic bold 24px sans-serif";
  canvas.strokeText(text, 0, 100);
}

// Create a simple state which no custom methods or state properties
//
// To do this without creating a custom class, just pass your unique handler
// functions in to the `GameLoopHtmlState` constructor.
GameLoopHtmlState initial_state =
  new SimpleHtmlState(
      onRender: (GameLoopHtml loop) {
        print("Render initial_state");
        drawText(canvas, "Initial State");
      },
      onKeyDown: (KeyboardEvent event) {
        event.preventDefault();

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

  CustomState(this.name, this.nextState);

  onKeyDown(KeyboardEvent event) {
    event.preventDefault();

    print("Key event");
    gameLoop.setState(nextState);
  }

  onRender(GameLoopHtml gameLoop) {
    print("Render $name");
    drawText(canvas, name);

    _renderSquare();
  }

  _renderSquare() {
    canvas.fillRect(0, 0, 20, 20);
  }

  void onFullScreenChange(GameLoop gameLoop) {
    // IGNORED
  }

  void onPointerLockChange(GameLoop gameLoop) {
    // IGNORED
  }

  void onResize(GameLoop gameLoop) {
    // IGNORED
  }

  void onTouchEnd(GameLoop gameLoop, GameLoopTouch touch) {
    // IGNORED
  }

  void onTouchStart(GameLoop gameLoop, GameLoopTouch touch) {
    // IGNORED
  }

  void onUpdate(GameLoop gameLoop) {
    // IGNORED
  }
}

CustomState custom_state_1 = new CustomState("Custom State 1", custom_state_2);
CustomState custom_state_2 = new CustomState("Custom State 2", menu_state);

class CanvasMenuState extends MenuState {

  CanvasRenderingContext2D canvas;

  CanvasMenuState(this.canvas, options, [selected = 0]) : super(options, selected);

  void onRender(GameLoop gameLoop) {
    print("Rendering Menu");
    drawText(canvas, options[selected].text);
  }

  void onFullScreenChange(GameLoop gameLoop) {
    // IGNORED
  }

  void onPointerLockChange(GameLoop gameLoop) {
    // IGNORED
  }

  void onResize(GameLoop gameLoop) {
    // IGNORED
  }

  void onTouchEnd(GameLoop gameLoop, GameLoopTouch touch) {
    // IGNORED
  }

  void onTouchStart(GameLoop gameLoop, GameLoopTouch touch) {
    // IGNORED
  }

  void onUpdate(GameLoop gameLoop) {
    // IGNORED
  }
}

CanvasMenuState menu_state =
  new CanvasMenuState(canvas,
    [ new MenuOption("Start", () { gameLoop.setState(initial_state); }),
      new MenuOption("Quit", () { gameLoop.setState(quit_state); } )]);

SimpleHtmlState quit_state = new SimpleHtmlState(onRender: (loop) {
  drawText(canvas, "QUIT!!");
});

main() {
  CanvasElement element = querySelector(".game-element");
  gameLoop = new GameLoopHtml(element);
  canvas = element.context2D;

  gameLoop.setState(initial_state);

  gameLoop.start();
}