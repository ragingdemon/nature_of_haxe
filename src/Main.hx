package ;

import util.Attractor;
import util.Gaussian;
import util.Liquid;
import util.Noise;
import util.PVector;
import util.Walker;
import util.Mover;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import openfl.Assets;
import openfl.events.MouseEvent;

class Main extends Sprite 
{	
	var inited:Bool;
	var halfWith:Float;
	var halfHeight:Float;
	var previosTime:Int;
	var elapsed:Float;	
	var movers:Array<Mover>;
	var mousePosition:PVector;
	var windForce:PVector;
	var gravity:PVector;
	var liquid:Liquid;
	var attractor:Attractor;

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
		
		previosTime = Lib.getTimer();
		halfWith = stage.stageWidth / 2;
		halfHeight = stage.stageHeight / 2;
		
		movers = [for (i in 0...1) new Mover(Math.random() * stage.stageWidth, 10, Math.random() * 20)];	
		//movers = [for (i in 0...1) new Mover( halfWith-halfWith/4, halfHeight - 5, 1)];
		windForce = new PVector(0.01, 0);
		gravity = new PVector(0, 0.1);
		liquid = new Liquid(0, halfHeight, stage.stageWidth, halfHeight, 0.1);
		attractor = new Attractor(20, halfWith, halfHeight);
		for (j in 0...movers.length) 
		{
			var bitmap:Bitmap = new Bitmap(Assets.getBitmapData("img/triangle.jpg"));
			movers[j].sprite.addChild(bitmap);
			//center bitmap in sprite
			bitmap.x = - bitmap.width / 2;
			bitmap.y = - bitmap.height / 2;			
			addChild(movers[j].sprite);
		}
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
		drawMover();		
		//drawGravity();
	}
	
	public function drawMover():Void
	{
		graphics.clear();
		drawLiquid();
		for (i in 0...movers.length) 
		{
			//graphics.beginFill(0x000000);
			var mover:Mover = movers[i];
			//graphics.drawCircle(mover.location.x,mover.location.y,mover.mass);
			//graphics.endFill();		
			//mover.applyForce(gravity);
			mover.applyForce(PVector.times(gravity,mover.mass));
			//mover.applyForce(windForce);
			if (mover.isInsideLiquid(liquid)) 
			{				
				mover.dragLiquid(liquid);
			}
			mover.update();
			mover.checkEdges(stage.stageWidth, stage.stageHeight);
		}				
	}
	
	public function drawLiquid():Void
	{		
		graphics.beginFill(0x0000FF, 0.25);
		graphics.drawRect(liquid.x, liquid.y, liquid.w, liquid.h);
		graphics.endFill();
	}
	
	
	public function drawGravity():Void
	{
		graphics.clear();
		graphics.beginFill(0x000000);
		graphics.drawCircle(attractor.location.x, attractor.location.y, attractor.mass);
		graphics.endFill();
		for (i in 0...movers.length) 
		{
			var mover:Mover = movers[i];
			graphics.beginFill(0x000000);			
			graphics.drawCircle(mover.location.x, mover.location.y, 10);
			graphics.endFill();
			var force:PVector = attractor.attract(mover);
			mover.applyForce(force);
			mover.update();
			//mover.checkEdges(stage.stageWidth, stage.stageHeight);
			//mover.teleportation(stage.stageWidth, stage.stageHeight,10);
		}			
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = openfl.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = openfl.display.StageScaleMode.NO_SCALE;		
		Lib.current.addChild(new Main());
	}
}
