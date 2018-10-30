package code {

	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.ui.Keyboard;


	public class Player extends MovieClip {
		/** Holds the base gravity that the player will always be reset to. */
		private const baseGravity: Point = new Point(0, 1000);
		/** Holds the curret gravity of the player. */
		private var gravity: Point = new Point(0, 1000);
		/** The X and Y velocity of the player. */
		private var velocity: Point = new Point(0, 0);
		/** The maximum horizontal Speed the player can reach. */
		private var maxSpeed: Number = 200;
		/** The amount of time in seconds the player has been in the air since their last jump. */
		private var airTime: Number = 0;
		/** The amount of times the player has jumped since touching the ground (should max at 2). */
		private var jumpCount: Number = 0;
		/** Keeps track of if the player is in the air from a jump. */
		private var isJumping: Boolean = false;
		/** The rate at which the player can accelerate on the horizontal axis. */
		private const HORIZONTAL_ACCELERATION: Number = 1000;
		/** The rate at which the player decelerate on the horizontal axis. */
		private const HORIZONTAL_DECELERATION: Number = 800;
		/** The rate at which the player can accelerate on the vertical axis. */
		private const VERTICAL_ACCELERATION: Number = 2000;



		public function Player() {
			// constructor code
		} // ends constructor

		public function update(): void {

			//if(KeyboardInput.OnKeyDown(Keyboard.SPACE)){////////
			//	trace("jump");
			//}

			handleWalking();

			handleJump();

			doPhysics();

			detectGround();

		}

		private function detectGround(): void {
			//look at y position
			var ground: Number = 350;
			var softGround: Number = 300;
			if (y > ground) {
				y = ground; // clamp
				velocity.y = 0;

			}
			if (y > softGround && velocity.y > 0) {
				airTime = 0;
				jumpCount = 0;
				if (isJumping == true) isJumping = false;
			}
		}

		/**
		 * This function looks at the keyboard input in order to accelerate the player
		 * left or right. As a result , this function changes the player's velocity.
		 */
		private function handleWalking(): void {
			if (KeyboardInput.IsKeyDown(Keyboard.LEFT) || KeyboardInput.IsKeyDown(Keyboard.A)) velocity.x -= HORIZONTAL_ACCELERATION * Time.dt;
			if (KeyboardInput.IsKeyDown(Keyboard.RIGHT) || KeyboardInput.IsKeyDown(Keyboard.D)) velocity.x += HORIZONTAL_ACCELERATION * Time.dt;

			if (!KeyboardInput.IsKeyDown(Keyboard.LEFT) && !KeyboardInput.IsKeyDown(Keyboard.RIGHT) && !KeyboardInput.IsKeyDown(Keyboard.A) && !KeyboardInput.IsKeyDown(Keyboard.D)) {
				if (velocity.x < 0) { //moving left
					velocity.x += HORIZONTAL_DECELERATION * Time.dt;
					if (velocity.x > 0) velocity.x = 0; //clamp
				}
				if (velocity.x > 0) { //moving right
					velocity.x -= HORIZONTAL_DECELERATION * Time.dt;
					if (velocity.x < 0) velocity.x = 0; //clamp
				}
			}
		}

		/**
		 * This function looks at the keyboard input to tell when the player can and should jump.--------------
		 */
		private function handleJump(): void {
			if (KeyboardInput.OnKeyDown(Keyboard.SPACE) && airTime < .3 && jumpCount <= 2) {
				isJumping = true;
				gravity.y = 500;
				jumpCount += 1;
				airTime = 0;
				//trace(jumpCount);
			}
			if (KeyboardInput.IsKeyDown(Keyboard.SPACE) && airTime < .3 && isJumping == true) {
				velocity.y -= VERTICAL_ACCELERATION * Time.dt;
			}
		}

		private function doPhysics(): void {
			// apply gravity to velocity:
			jumpingPhysics();
			velocity.x += gravity.x * Time.dt;
			velocity.y += gravity.y * Time.dt;



			// constrain to max speed:
			if (velocity.x > maxSpeed) velocity.x = maxSpeed;
			if (velocity.x < -maxSpeed) velocity.x = -maxSpeed;

			// apply velocity to position:
			x += velocity.x * Time.dt;
			y += velocity.y * Time.dt;
		}

		/**
		 * Controls the altered gravity when jumping.--------------------
		 */
		private function jumpingPhysics(): void {
			if (isJumping == true) {
				airTime += Time.dt;
				if (airTime > .3) {
					//isJumping = false
					//if(velocity.y < 0)gravity.y += 200 * Time.dt;
					gravity.y = baseGravity.y;
				}
			}
			/*if (isJumping == false) {
				gravity.y = baseGravity.y;
				airTime = 0;
			}*/
		}


	} // ends plyer class

} // ends package