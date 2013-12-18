/*
  Copyright (C) 2013 John McCutchan <john@johnmccutchan.com>

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
*/

part of game_loop_html;

/** A set of GameLoop handlers for HTML games.
 *
 * See GameLoopState for an example of creating and using a GameState.
 */
abstract class GameLoopHtmlState extends GameLoopState {
  void onFullScreenChange(GameLoop gameLoop);
  void onKeyDown(KeyboardEvent event);
  void onPointerLockChange(GameLoop gameLoop);
  void onRender(GameLoop gameLoop);
  void onResize(GameLoop gameLoop);
  void onTouchEnd(GameLoop gameLoop, GameLoopTouch touch);
  void onTouchStart(GameLoop gameLoop, GameLoopTouch touch);
}

class SimpleHtmlState extends GameLoopHtmlState {
  GameLoopRenderFunction _onRender = (GameLoop loop) { };
  GameLoopResizeFunction _onResize = (GameLoop loop) { };
  GameLoopFullscreenChangeFunction _onFullscreenChange =
      (GameLoop gameLoop) { };
  GameLoopPointerLockChangeFunction _onPointerLockChange =
      (GameLoop gameLoop) { };
  GameLoopTouchEventFunction _onTouchStart =
      (GameLoop gameLoop, GameLoopTouch touch) { };
  GameLoopTouchEventFunction _onTouchEnd =
      (GameLoop gameLoop, GameLoopTouch touch) { };
  GameLoopKeyDownHandler _onKeyDown = (KeyboardEvent event) { };
  GameLoopUpdateFunction _onUpdate = (GameLoop gameLoop) { };

  SimpleHtmlState({
    GameLoopRenderFunction onRender: null,
    GameLoopResizeFunction onResize: null,
    GameLoopFullscreenChangeFunction onFullscreenChange: null,
    GameLoopPointerLockChangeFunction onPointerLockChange: null,
    GameLoopTouchEventFunction onTouchStart: null,
    GameLoopTouchEventFunction onTouchEnd: null,
    GameLoopKeyDownHandler onKeyDown: null,
    GameLoopUpdateFunction onUpdate: null
  }) {
    if (onRender != null) {
      _onRender = onRender;
    }

    if (onResize != null) {
      _onResize = onResize;
    }

    if (onFullscreenChange != null) {
      _onFullscreenChange = onFullscreenChange;
    }

    if (onPointerLockChange != null) {
      _onPointerLockChange = onPointerLockChange;
    }

    if (onTouchStart != null) {
      _onTouchStart = onTouchStart;
    }

    if (onTouchEnd != null) {
      _onTouchEnd = onTouchEnd;
    }

    if (onKeyDown != null) {
      _onKeyDown = onKeyDown;
    }

    if (onUpdate != null) {
      _onUpdate = onUpdate;
    }
  }

  void onFullScreenChange(GameLoop gameLoop) {
    _onFullscreenChange(gameLoop);
  }

  void onKeyDown(KeyboardEvent event) {
    _onKeyDown(event);
  }

  void onPointerLockChange(GameLoop gameLoop) {
    _onPointerLockChange(gameLoop);
  }

  void onRender(GameLoop gameLoop) {
    _onRender(gameLoop);
  }

  void onResize(GameLoop gameLoop) {
    _onResize(gameLoop);
  }

  void onTouchEnd(GameLoop gameLoop, GameLoopTouch touch) {
    _onTouchEnd(gameLoop, touch);
  }

  void onTouchStart(GameLoop gameLoop, GameLoopTouch touch) {
    _onTouchStart(gameLoop, touch);
  }

  void onUpdate(GameLoop gameLoop) {
    _onUpdate(gameLoop);
  }
}

typedef void MenuStateSelectedFunction();

class MenuOption {
  String text;
  MenuStateSelectedFunction onSelected;

  MenuOption(this.text, this.onSelected);
}

abstract class MenuState extends GameLoopHtmlState {
  List<MenuOption> options;
  int selected;

  MenuState(this.options, [ this.selected = 0 ]);

  _selectPrev() {
    selected = selected - 1;
    if (selected < 0) {
      selected = options.length - 1;
    }
  }

  _selectNext() {
    selected = selected + 1;
    if (selected >= options.length){
      selected = 0;
    }
  }

  _selectOption() {
    options[selected].onSelected();
  }

  void onKeyDown(KeyboardEvent event) {
    event.preventDefault();

    switch (event.which) {
      case Keyboard.DOWN:
      case Keyboard.J:
        _selectNext();
        break;

      case Keyboard.UP:
      case Keyboard.K:
        _selectPrev();
        break;

      case Keyboard.ENTER:
      case Keyboard.SPACE:
        _selectOption();
        break;
    }
  }
}