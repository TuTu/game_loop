part of game_loop_html;

class GameLoopHtmlState extends GameLoopState {
  GameLoopFullscreenChangeFunction onFullScreenChange;
  GameLoopKeyDownHandler onKeyDown;
  GameLoopPointerLockChangeFunction onPointerLockChange;
  GameLoopRenderFunction onRender;
  GameLoopResizeFunction onResize;
  GameLoopTouchEventFunction onTouchEnd;
  GameLoopTouchEventFunction onTouchStart;
  
  GameLoopHtmlState(
      { GameLoopFullscreenChangeFunction onFullScreenChange: null,
        GameLoopKeyDownHandler onKeyDown: null,
        GameLoopPointerLockChangeFunction onPointerLockChange: null,
        GameLoopRenderFunction onRender: null,
        GameLoopResizeFunction onResize: null,
        GameLoopTouchEventFunction onTouchEnd: null,
        GameLoopTouchEventFunction onTouchStart: null }) {
    this.onFullScreenChange = onFullScreenChange;
    this.onKeyDown = onKeyDown;
    this.onPointerLockChange = onPointerLockChange;
    this.onRender = onRender;
    this.onResize = onResize;
    this.onTouchEnd = onTouchEnd;
    this.onTouchStart = onTouchStart;
  }
}