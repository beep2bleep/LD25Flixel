package 
{
	import flash.utils.Timer;
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	[SWF(width="640", height="480", backgroundColor="#000000")] //Set the size and color of the Flash file
 
	public class HelloWorld extends FlxGame
	{
		public static var Sounds:Boolean = true;
		public static var MuteTime:FlxTimer = new FlxTimer();
		public static var HighScore:int = 0;
		private var bricks:FlxGroup;
		
		public function HelloWorld()
		{
			super(320, 240, AttractState, 2, 60, 60); //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState
			forceDebugger = true;
		}
	}
}