package code {
	import flash.events.KeyboardEvent;
	import flash.display.Stage;
	import flash.events.MouseEvent;

	/** 
	 * This class keeps track of what keys are being pressed down.
	 */
	public class KeyboardInput {

		static public var keysState:Array = new Array();
		static public var keysPrevState:Array = new Array();
		

		/**
		 * This function adds event listeners to handle KeyboardEvents.
		 * @param stage:Stage keeps track of things on the stage.
		 */
		static public function setup(stage: Stage) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
		}

		/**
		 * cache all the key values , for the next frmae.
		 */
		static public function update():void {
			keysPrevState = keysState.slice();// in this context , slice() gives us a copy of the array
		}
		/**
		 * This updates to keep track of the state of the keys.
		 * @param keyCode: int keeps track of what key.
		 * @param isDown: Boolean keeps track of if the key is pressed or not.
		 */
		static private function updateKey(keyCode: int, isDown: Boolean): void {

			/*if (keyCode == 13) keyEnter = isDown;
			if (keyCode == 37) keyLeft = isDown;
			if (keyCode == 38) keyUp = isDown;
			if (keyCode == 39) keyRight = isDown;
			if (keyCode == 40) keyDown = isDown;
			if (keyCode == 27) keyEscape = isDown;
			if (keyCode == 87) keyW = isDown;
			if (keyCode == 65) keyA = isDown;
			if (keyCode == 83) keyS = isDown;
			if (keyCode == 68) keyD = isDown;
			if (keyCode == 32) keySpace = isDown;
			*/
			
			keysState[keyCode] = isDown;
		}

		/**
		 * Marks keys as down when they are pressed.
		 * @param e: KeyboardEvent keeps track of key board event.
		 */
		static private function handleKeyDown(e: KeyboardEvent): void {
			//trace(e.keyCode);
			updateKey(e.keyCode, true);
		}

		/**
		 * Marks keys as up when they are not pressed.
		 * @param e: KeyboardEvent keeps track of key board event.
		 */
		static private function handleKeyUp(e: KeyboardEvent): void {

			updateKey(e.keyCode, false);
		}
		
		static public function IsKeyDown (keyCode : int):Boolean{
			if(keyCode < 0 ) return false;
			if(keyCode >= keysState.length)return false;
			return keysState[keyCode];
		}
		
		static public function OnKeyDown(keyCode:int):Boolean{
			if(keyCode < 0 ) return false;
			if(keyCode >= keysState.length)return false;
			
			return (keysState[keyCode] && !keysPrevState[keyCode]);
		}

	}

}