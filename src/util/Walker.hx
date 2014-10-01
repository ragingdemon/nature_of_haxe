package util ;

class Walker
{
	public var x:Float;	
	public var y:Float;	
	public var s:Float;
	public var r:Float;
	


	public function new(x:Float = 0, y:Float = 0, s:Float = 1) 
	{
		this.x = x;
		this.y = y;
		this.s = s;
		r = 32;
	}
	
	public function step():Void 
	{
		var xPro:Float = Math.random();
		var yPro:Float = Math.random();
				
		if (xPro < 0.33) {
			x += s;
		}else if (xPro < 0.66) 
		{
			x += -s;
		}
		if (yPro < 0.33) {
			y += s;
		}else if (yPro < 0.66) 
		{
			y += -s;
		}
		r = Math.random()*32 + 32;
	}


}