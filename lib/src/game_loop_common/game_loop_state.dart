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

part of game_loop_common;

/** Collects together a set of GameLoop handlers into a single object.
 *
 * This is very useful if your game switches back and forth between sets of
 * handlers (such as switching from an intro, menu, or gameplay state.)
 *
 * Use `GameLoop``s `state` property to set the games current state:
 *
 *     menu_state = new SimpleState(onUpdate: (gameLoop) { ... });
 *     gameLoop.state = menu_state;
 *
 * If you want to track state specific information, you should consider creating
 * a subclass of GameState. You can then pass this in to the GameLoop.
 *
 *     class MenuState extends GameLoopHtmlState {
 *         List<String> options;
 *         int selected;
 *
 *         MenuState(this.options, this.selected);
 *
 *         onRender(GameLoop gameLoop) {
 *           // SINP! RENDER THE MENU HERE...
 *         }
 *
 *         // SNIP! UNUSED HANDLERS REMOVED FOR CLARITY...
 *     }
 *
 * Look at SimpleState and SimpleHtmlState for examples.
 *
 * You can then create an instance of this custom state and set it like any
 * other.
 *
 *     custom_menu_state = new MenuState(['Start', 'Quit'], 0);
 *     gameLoop.state = custom_menu_state;
 *
 * See the /examples folder for a working example.
 */
abstract class GameLoopState {
  void onUpdate(GameLoop gameLoop);
}

class SimpleState extends GameLoopState {
  GameLoopUpdateFunction _onUpdate = (GameLoop gameLoop) { };

  SimpleState({GameLoopUpdateFunction onUpdate: null}) {
    if (onUpdate != null) {
      _onUpdate = onUpdate;
    }
  }

  void onUpdate(GameLoop gameLoop) {
    _onUpdate(gameLoop);
  }
}