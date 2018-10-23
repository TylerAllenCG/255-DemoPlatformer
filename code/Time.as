package code {
	import flash.utils.getTimer;

	/** 
	 * This class keeps track of delta time.
	 */
	public class Time {

		/** The amount of time that has passed since the last frame. */
		public static var dt: Number = 0;
		/** The amount of time that has passed since the start of the game. */
		public static var time: Number = 0;
		/** The amount of time that had passed since the start of the game last frame. */
		private static var timePrev: Number = 0;
		/** A scaled version of deltaTime(dt). Uses Time.scale. Measured in seconds. */
		private static var dtScaled: Number = 0;
		/** A scaler for dtScaled. Use for slowmo and pause effects. */
		private static var scale: Number = 1;
		
	

		/** 
		 * Updates delta time.
		 * Called once per frame in gameLoop.
		 */
		public static function update(): void {
			time = getTimer();
			dt = (time - timePrev) / 1000;
			dtScaled = dt * scale;
			timePrev = time; //cache next frame.
		}
	}
}