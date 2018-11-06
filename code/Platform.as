package code {

	import flash.display.MovieClip;


	public class Platform extends MovieClip {

		/** The platform's AABB for collision detection. */
		public var collider: AABB;

		/** 
		 * The set up for each platform.
		 * Creates its AABB and adds the platform to the platforms array.
		 */
		public function Platform() {
			collider = new AABB(width / 2, height / 2);
			collider.calcEdges(x, y);

			Game.platforms.push(this);
			// constructor code
		}
	}

}