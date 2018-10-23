package code {

	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.ui.Keyboard;


	public class Player extends MovieClip {

		private var gravity: Point = new Point(0, 100);
		
		private var velocity: Point = new Point(1, 5);
		
		private var maxSpeed: Number = 200;
		
		private const HORIZONTAL_ACCELERATION:Number = 800;
		
		private const HORIZONTAL_DECELERATION:Number = 800;
		


		public function Player() {
			// constructor code
		} // ends constructor

		public function update(): void {

			if(KeyboardInput.OnKeyDown){////////
				trace("jump");
			}
			
			handleWalking();
			
			doPhysics();

			detectGround();

		}

		private function detectGround(): void {
			//look at y position
			var ground: Number = 350;
			if (y > ground) {
				y = ground; // clamp
				velocity.y = 0;
			}
		}

		/**
		 * This function looks at the keyboard input in order to accelerate the player
		 * left or right. As a result , this function changes the player's velocity.
		 */
		private function handleWalking():void{
			if(KeyboardInput.IsKeyDown(Keyboard.LEFT))velocity.x -= HORIZONTAL_ACCELERATION *Time. dt;
			if(KeyboardInput.IsKeyDown(Keyboard.RIGHT))velocity.x += HORIZONTAL_ACCELERATION *Time. dt;
			
			if(!KeyboardInput.IsKeyDown(Keyboard.LEFT) && !KeyboardInput.IsKeyDown(Keyboard.RIGHT)){
				if(velocity.x < 0){//moving left
					velocity.x += HORIZONTAL_DECELERATION * Time.dt;
					if(velocity.x > 0) velocity.x = 0;//clamp
				}
				if(velocity.x > 0){//moving right
					velocity.x -= HORIZONTAL_DECELERATION * Time.dt;
					if(velocity.x < 0) velocity.x = 0;//clamp
				}
			}
		}
		
		private function doPhysics(): void {
			// apply gravity to velocity:
			velocity.x += gravity.x * Time.dt;
			velocity.y += gravity.y * Time.dt;
			
			// constrain to max speed:
			if(velocity.x > maxSpeed) velocity.x = maxSpeed;
			if(velocity.x < -maxSpeed) velocity.x = -maxSpeed;

			// apply velocity to position:
			x += velocity.x * Time.dt;
			y += velocity.y * Time.dt;
		}


	} // ends plyer class

} // ends package