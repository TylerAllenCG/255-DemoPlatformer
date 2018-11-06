﻿package code {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;

	/**
	 * The fountational class of this game.
	 * Everything runs through this class.
	 */
	public class Game extends MovieClip {

		static public var platforms:Array = new Array();
		
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

			doCollistionDetection();
			
			KeyboardInput.update();
		} //ends gameLoop
		
		private function doCollistionDetection(): void{
			
			for (var i:int = 0; i < platforms.length; i++){
				if(player.collider.checkOverlap(platforms[i].collider)){// if overlapping
					// find the fix:
					var fix:Point = player.collider.findOverlapFix(platforms[i].collider);
					// apply the fix:
					player.applyFix(fix);
				}
			}// ends for loop
			
			
			
		}

	} //ends game class

} // ends package