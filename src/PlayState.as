package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxColor;
 
	public class PlayState extends FlxState
	{
		
		[Embed(source="../data/Pickup_Coin8.mp3")] private var SoundEffect:Class;
		[Embed(source="../data/Pickup_Coin39.mp3")] private var SoundEffect2:Class;
	
		
		private var bat:FlxSprite;
		private var ball:FlxSprite;
		
		private var walls:FlxGroup;
		private var leftWall:FlxTileblock;
		private var rightWall:FlxTileblock;
		private var topWall:FlxTileblock;
		private var bottomWall:FlxTileblock;
		
		private var level:int;
		private var score:int;
		
		private var bricks:FlxGroup;
		
		override public function create():void
		{
			level = 0;
			score = 0;
			
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
			//add(new FlxText(0,0,100,"Hello, World!")); //adds a 100px wide text field at position 0,0 (upper left)
		}
		
		public function destroyLevel():void 
		{
			for (var i:int = 0; i < bricks.length; i++)
			{
				//if (bricks.members[i].exists)
				{
					bricks.members[i].kill();
				}
			}
			ball.kill();
			bat.kill();
		}
		
		public function setupLevel():void 
		{
			bat = new FlxSprite(180, 220).makeGraphic(40, 6, 0xffd63bc3);
			bat.immovable = true;
			
			ball = new FlxSprite(180, 160).makeGraphic(6, 6, 0xffd63bc3);
			ball.elasticity = 1;
			ball.maxVelocity.x = 200;
			ball.maxVelocity.y = 200;
			ball.velocity.y = 200;
			
			
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
			add(bat);
			add(ball);
			add(bricks);
			
			//Possible differences based on level
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.M)
			{
				HelloWorld.Sounds = !(HelloWorld.Sounds);
			}
			
			bat.velocity.x = 0;
			
			if (FlxG.keys.LEFT && bat.x > 10)
			{
				bat.velocity.x = -300;
			}
			else if (FlxG.keys.RIGHT && bat.x < 270)
			{
				bat.velocity.x = 300;
			}
			
			if (bat.x < 10)
			{
				bat.x = 10;
			}
			
			if (bat.x > 270)
			{
				bat.x = 270;
			}
			FlxG.collide(bat, ball, ping);
			FlxG.collide(ball, bricks, hit);
			FlxG.collide(ball, leftWall, hitsides);
			FlxG.collide(ball, rightWall, hitsides);
			FlxG.collide(ball, bottomWall, hitbottom);
			FlxG.collide(ball, topWall, hittop);
		}
		
		private function hitbottom(_ball:FlxSprite, _wall:FlxSprite):void
		{
			if(HelloWorld.Sounds)FlxG.play(SoundEffect2);
			
			HelloWorld.HighScore = score;
			level = 0;
			FlxG.switchState(new AttractState());
			//When implementing penelty
			//destroyLevel();
			//resetGame();
			//setupLevel();
		}
		
		private function hittop(_ball:FlxSprite, _wall:FlxSprite):void
		{
			
			if(HelloWorld.Sounds)FlxG.play(SoundEffect2);
			
			level += level;
			levelUpChar();
			
		}
		
		public function levelUpChar():void 
		{
			destroyLevel();
			//add(new FlxText(0, 200, FlxG.width, "PUSH").setFormat(null, 18, 0xffffffff, "center"));
            //Goto new state
			setupLevel();
		}
		
		private function hitsides(_ball:FlxSprite, _wall:FlxSprite):void
		{
			
			if(HelloWorld.Sounds)FlxG.play(SoundEffect2);
			
			
			//var emitter:FlxEmitter = new FlxEmitter(_wall.x+(_wall.width/2),_wall.y+(_wall.height/2)); //x and y of the emitter
			//var particles:int = 15;
			//if (_wall.x = 0)
			{
			//create();
			}
		}
		
		private function hit(_ball:FlxSprite, _brick:FlxSprite):void
		{
			//_brick.flicker();
			_brick.exists = false;
			
			if(HelloWorld.Sounds)FlxG.play(SoundEffect2);
			
			
			//var emitter:FlxEmitter = new FlxEmitter(_brick.x+(_brick.width/2),_brick.y+(_brick.height/2)); //x and y of the emitter
			//var particles:int = 5;
			//
			//
			//
			//for(var i:int = 0; i < particles; i++)
			//{
				//var particle:FlxParticle = new FlxParticle();
				//var temp:String = _brick.color.toString(16);
				//particle.makeGraphic(4, 4, 0x55ffffff);
				//particle.exists = false;
				//emitter.add(particle);
			//}
			 //
			//add(emitter);
			//emitter.start();
			
		}
		
		private function ping(_bat:FlxObject, _ball:FlxObject):void
		{
			var batmid:int = _bat.x + 20;
			var ballmid:int = _ball.x + 3;
			var diff:int;
			
			if (ballmid < batmid)
			{
				//	Ball is on the left of the bat
				diff = batmid - ballmid;
				ball.velocity.x = ( -10 * diff);
			}
			else if (ballmid > batmid)
			{
				//	Ball on the right of the bat
				diff = ballmid - batmid;
				ball.velocity.x = (10 * diff);
			}
			else
			{
				//	Ball is perfectly in the middle
				//	A little random X to stop it bouncing up!
				ball.velocity.x = 2 + int(Math.random() * 8);
			}
			if(HelloWorld.Sounds)FlxG.play(SoundEffect);
		}
		
	}
}