 package code {

	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.ui.Keyboard;

	/**
	 * This class contains the behavior of the player object.
	 */
	public class Player extends MovieClip {
		/** Holds the base gravity that the player will always be reset to. */
		private const baseGravity: Point = new Point(0, 2500);
		/** Holds the curret gravity of the player. */
		private var gravity: Point = new Point(0, 2500);
		/** The X and Y velocity of the player. */
		private var velocity: Point = new Point(0, 0);
		/** The maximum horizontal Speed the player can reach. */
		private var maxSpeed: Number = 300;
		/** The amount of time in seconds the player has been in the air since their last jump. */
		private var airTime: Number = 0;
		/** The amount of times the player has jumped since touching the ground (should max at 2). */
		private var jumpCount: Number = 0;
		/** Keeps track of if the player is in the air from a jump. */
		private var isGrounded: Boolean = false;
		/** Keeps track of if the player is moving upward, effects gravity. */
		private var isJumping:Boolean = false;
		/** The rate at which the player can accelerate on the horizontal axis. */
		private const HORIZONTAL_ACCELERATION: Number = 1000;
		/** The rate at which the player decelerate on the horizontal axis. */
		private const HORIZONTAL_DECELERATION: Number = 800;
		/** The rate at which the player can accelerate on the vertical axis. */
		private const VERTICAL_ACCELERATION: Number = 1500;
		
		private var jumpVelocity:Number = 600;
		
		public var collider:AABB;

		/**
		 * The constructor code for the player.
		 * Right now it contains nothing as the player is already placed on the stage to begin with.
		 */
		public function Player() {
			// constructor code
			collider = new AABB(width/2, height/2);
		} // ends constructor

		/**
		 * This updates the player object based on physics and the player's input.
		 */
		public function update(): void {

			handleWalking();

			handleJump();

			doPhysics();

			detectGround();
			
			jumpingTimer();
			
			collider.calcEdges(x, y);
			//trace(velocity.y);
		}

		/**
		 * This function sets a maximum y value that the player can not cross.
		 * This also adds a small area above the ground where the player can jump again.
		 */
		private function detectGround(): void {
			//look at y position
			var ground: Number = 350;
			//var softGround: Number = 300;
			if (y > ground) {
				y = ground; // clamp
				velocity.y = 0;
				airTime = 0;
				jumpCount = 0;
				if (isGrounded == false) isGrounded = true;
				isJumping = false;
			}
			/*if (y > softGround && velocity.y > 0) {
				airTime = 0;
				jumpCount = 0;
				if (isJumping == true) isJumping = false;
			}*/
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
		 * This function looks at the keyboard input to tell when the player can and should jump.
		 */
		private function handleJump(): void {
			if (KeyboardInput.OnKeyDown(Keyboard.SPACE) && velocity.y <= 400 && jumpCount <= 1) {
				isGrounded = false;
				isJumping = true;
				//gravity.y = 300;
				jumpCount += 1;
				airTime = 0;
				velocity.y = -jumpVelocity;
				
			}
			if (KeyboardInput.IsKeyDown(Keyboard.SPACE) && airTime < .3 && isGrounded == false) {
				//velocity.y -= VERTICAL_ACCELERATION * Time.dt;
				//gravity.y = 10;
			}
			if (!KeyboardInput.IsKeyDown(Keyboard.SPACE)) {
				isJumping = false;
				gravity.y = baseGravity.y;
			}
			if(velocity.y > 0) isJumping = false;
		}

		/**
		 * The physics that govern the player's position.
		 */
		private function doPhysics(): void {
			
			var gravityMultiplier:Number = .5;
			
			if(!isJumping) gravityMultiplier = 1;
			
			// apply gravity to velocity:
			//velocity.x += gravity.x * Time.dt * gravityMultiplier;
			velocity.y += gravity.y * Time.dt * gravityMultiplier;

			// constrain to max speed:
			if (velocity.x > maxSpeed) velocity.x = maxSpeed;
			if (velocity.x < -maxSpeed) velocity.x = -maxSpeed;

			// apply velocity to position:
			x += velocity.x * Time.dt;
			y += velocity.y * Time.dt;
		}

		/**
		 * Counts up the airTime when in the air and reaplys standard gravity after a set amount of air time.
		 */
		private function jumpingTimer(): void {
			if (isGrounded == false) {
				airTime += Time.dt;
				if (airTime > .3) {
					//gravity.y = baseGravity.y;
				}
			}
		}

	} // ends plyer class

} // ends package