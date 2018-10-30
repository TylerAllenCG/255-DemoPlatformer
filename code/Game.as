package code {

	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * The fountational class of this game.
	 * Everything runs through this class.
	 */
	public class Game extends MovieClip {

		/**
		 * Sets up the stage and starts running the gameloop.
		 */
		public function Game() {
			// constructor code
			KeyboardInput.setup(stage);
			addEventListener(Event.ENTER_FRAME, gameLoop);
		}

		/** 
		 * The core gameloop that updates everything.
		 * @param e: when entering a frame run this code.
		 */
		private function gameLoop(e: Event): void {
			Time.update();
			player.update();
			KeyboardInput.update();
		} //ends gameLoop

	} //ends game class

} // ends package