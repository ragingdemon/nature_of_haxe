package util;

class Liquid
{
	public var x:Float;
	public var y:Float;
	public var w:Float;
	public var h:Float;
	public var c:Float; //drag coefficient
	
	public function new(x,y,w,h,c) 
	{
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.c = c;
	}
	
}