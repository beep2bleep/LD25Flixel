package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxColor;
 
	public class AttractState extends FlxState
	{

		private var walls:FlxGroup;
		private var leftWall:FlxTileblock;
		private var rightWall:FlxTileblock;
		private var topWall:FlxTileblock;
		private var bottomWall:FlxTileblock;
		
		private var level:int;
		
		private var bricks:FlxGroup;
		
		override public function create():void
		{
			level = 0;
			HelloWorld.MuteTime.start(.1);
			
			walls = new FlxGroup;
			
			leftWall = new FlxTileblock(0, 0, 10, 240);
			leftWall.makeGraphic(10, 240, 0xffababab);
			walls.add(leftWall);
			
			rightWall = new FlxTileblock(310, 0, 10, 240);
			rightWall.makeGraphic(10, 240, 0xffababab);
			walls.add(rightWall);
			
			topWall = new FlxTileblock(0, 0, 320, 10);
			topWall.makeGraphic(320, 10, 0xffababab);
			walls.add(topWall);
			
			bottomWall = new FlxTileblock(0, 239, 320, 10);
			bottomWall.makeGraphic(320, 10, 0xff000000);
			walls.add(bottomWall);
			
			setupLevel();
			add(new FlxText(90, 120, 140, "Press Left or Right to Start")); //adds a 100px wide text field at position 0,0 (upper left)
			add(new FlxText(93,140,140,"Press M to Toggle Sounds")); //adds a 100px wide text field at position 0,0 (upper left)
		}

		
		public function setupLevel():void 
		{
			
			//	Some bricks
			bricks = new FlxGroup;
			
			var bx:int = 10;
			var by:int = 30;
			
			var brickColours:Array = [ 0xffd03ad1, 0xfff75352, 0xfffd8014, 0xffff9024, 0xff05b320, 0xff6d65f6 ];
			
			for (var y:int = 0; y < 6; y++)
			{
				for (var x:int = 0; x < 20; x++)
				{
					var tempBrick:FlxSprite = new FlxSprite(bx, by);
					tempBrick.makeGraphic(15, 15, brickColours[y]);
					tempBrick.immovable = true;
					bricks.add(tempBrick);
					bx += 15;
				}
				
				bx = 10;
				by += 15;
			}
			
			add(walls);
			add(bricks);
			
			//Possible differences based on level
		}
		
		override public function update():void
		{
			super.update();
			if (FlxG.keys.LEFT || FlxG.keys.RIGHT) {
				FlxG.switchState(new PlayState());// = new PlayState();
			}
			if (FlxG.keys.M)
			{
				if (HelloWorld.MuteTime.finished)
				{
					HelloWorld.MuteTime = new FlxTimer();
					HelloWorld.MuteTime.start(1);
					HelloWorld.Sounds = !(HelloWorld.Sounds);
					var emitter:FlxEmitter = new FlxEmitter(160,120); //x and y of the emitter
					var particles:int = 10;
					
					
					
					for(var i:int = 0; i < particles; i++)
					{
						var particle:FlxParticle = new FlxParticle();
						particle.makeGraphic(4, 4, 0x55ffffff);
						particle.exists = false;
						emitter.add(particle);
					}
					 
					add(emitter);
					emitter.start();
				
				}
				else
				{
					HelloWorld.MuteTime.start();
				}
			}
			
		}
	}
}