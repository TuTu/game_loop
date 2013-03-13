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

part of game_loop;

/** The position of a touch at a given time and frame. */
class GameLoopTouchPosition implements PositionInput {
  final int x;
  final int y;
  final int dx;
  final int dy;
  final double time;
  final int frame;
  GameLoopTouchPosition(this.x, this.y, this.dx, this.dy, this.time,
                        this.frame);
}

/** An active touch. Holds the touch id and history of positions */
class GameLoopTouch {
  final int id;
  final List<GameLoopTouchPosition> positions =
      new List<GameLoopTouchPosition>();
  GameLoopTouch(this.id);
}

/** The set of active touches. */
class GameLoopTouchSet {
  final Map<int, GameLoopTouch> activeTouches = new Map<int, GameLoopTouch>();
  final GameLoop gameLoop;
  GameLoopTouchSet(this.gameLoop);

  void _addPosition(GameLoopTouch glTouch, Touch touch) {
    GameLoopTouchPosition position = new GameLoopTouchPosition(
        touch.clientX,
        touch.clientY,
        0,
        0,
        gameLoop.gameTime, gameLoop.frame);
    glTouch.positions.add(position);
  }

  void _start(TouchEvent event) {
    event.changedTouches.forEach((Touch touch) {
      GameLoopTouch glTouch = new GameLoopTouch(touch.identifier);
      activeTouches[touch.identifier] = glTouch;
      _addPosition(glTouch, touch);
      if (gameLoop.onTouchStart != null) {
        gameLoop.onTouchStart(gameLoop, glTouch);
      }
    });
  }
  void _end(TouchEvent event) {
    event.changedTouches.forEach((Touch touch) {
      var glTouch = activeTouches[touch.identifier];
      assert(glTouch != null);
      activeTouches.remove(touch.identifier);
      if (gameLoop.onTouchEnd != null) {
        gameLoop.onTouchEnd(gameLoop, glTouch);
      }
    });
  }
  void _move(TouchEvent event) {
    event.changedTouches.forEach((Touch touch) {
      var glTouch = activeTouches[touch.identifier];
      assert(glTouch != null);
      _addPosition(glTouch, touch);
    });
  }
}
