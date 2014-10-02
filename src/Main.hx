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
	var halfWith:Float;
	var halfHeight:Float;
	var inited:Bool;
	var previosTime:Int;
	var elapsed:Float;
	var walker:Walker;
	var mover:Mover;
	var mousePosition:PVector;
	var windForce:PVector;
	var windMouse:PVector;

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
		halfWith = stage.stageWidth / 2;
		halfHeight = stage.stageHeight / 2;
		
		mover = new Mover(new PVector(halfWith, halfHeight));
		windForce = new PVector(0.01, 0);
		windMouse = new PVector( -0.2, 0);
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
	}
	
	public function drawMover():Void
	{
		stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouse_down);
		
		graphics.clear();
		graphics.beginFill(0x008040,0.25);
		graphics.drawCircle(mover.location.x,mover.location.y,16);
		graphics.endFill();
		//mover.setAcceleration(mousePosition);
		mover.applyForce(windForce);
		mover.update();
		mover.checkEdges(stage.stageWidth, stage.stageHeight);
		//mover.teleportation(stage.stageWidth, stage.stageHeight,16);		
	}
	
	private function onMouse_move(event:MouseEvent)
	{				
		mousePosition = new PVector(event.localX, event.localY);		
	}
	
	private function onMouse_down(event:MouseEvent):Void 
	{		
		trace("get in mouse event");
		mover.applyForce(windMouse);
		trace("acceleration of mover:" + mover.acceleration);
		stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouse_down);
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = openfl.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = openfl.display.StageScaleMode.NO_SCALE;		
		Lib.current.addChild(new Main());
	}
}
