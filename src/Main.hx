package ;

import util.Gaussian;
import util.Noise;
import util.PVector;
import util.Walker;
import util.Mover;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import openfl.Assets;
import openfl.events.MouseEvent;


class Main extends Sprite 
{
	var inited:Bool;
	var previosTime:Int;
	var elapsed:Float;
	var walker:Walker;
	var mover:Mover;
	var mousePosition:PVector;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;

		stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouse_move);
		previosTime = Lib.getTimer();
		walker = new Walker(stage.stageWidth / 2, stage.stageHeight / 2, 8);
		mover = new Mover(new PVector(stage.stageWidth / 2, stage.stageHeight / 2));				
	}

	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
		addEventListener(Event.ENTER_FRAME, loop);
	}		
	
	public function deltaTime():Void 
	{
		var currentTime:Int = Lib.getTimer();
		var delta = currentTime - previosTime;
		elapsed = delta / 1000;
	}
	
	public function loop(e:Event):Void 
	{		
		deltaTime();
		//draw();
		//walker.step();
		//drawGaussian();
		drawMover();
		
	}
	
	public function draw():Void 
	{
		graphics.clear();
		graphics.beginFill(0x008040);
		graphics.drawCircle(walker.x, walker.y,walker.r);
		graphics.endFill();
	}
	
	public function drawGaussian():Void 
	{		
		var gaussian:Float = Gaussian.getGaussian(stage.stageWidth / 2, 60);
		graphics.beginFill(0x008040,0.25);
		graphics.drawCircle(gaussian,stage.stageHeight / 2, 16);
		graphics.endFill();
	}
	
	public function drawPerlin():Void 
	{
		var noise:Noise = new Noise(stage.stageWidth,stage.stageHeight);
		for (i in 0...stage.stageWidth) 
		{
			for (j in 0...stage.stageHeight) 
			{
				drawRectangel(i, j, noise.gridNoise[i][j]);
			}
		}
	}
	
	public function drawRectangel(x:Float, y:Float, alpha:Float):Void 
	{				
		graphics.beginFill(0x000000, alpha);		
		graphics.drawRect(x, y, 1, 1);
		graphics.endFill();
	}
	
	public function drawMover():Void
	{		
		graphics.clear();
		graphics.beginFill(0x008040,0.25);
		graphics.drawCircle(mover.location.x,mover.location.y,16);
		graphics.endFill();
		mover.setAcceleration(mousePosition);
		mover.update();
		mover.checkEdges(stage.stageWidth, stage.stageHeight);
		//mover.teleportation(stage.stageWidth, stage.stageHeight,16);
	}
	
	public function onMouse_move(event:MouseEvent)
	{		
		mousePosition = new PVector(event.localX, event.localY);		
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = openfl.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = openfl.display.StageScaleMode.NO_SCALE;		
		Lib.current.addChild(new Main());
	}
}
