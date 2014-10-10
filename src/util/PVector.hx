package util;

class PVector
{
	public var x:Float;
	public var y:Float;
	
	public function new(x:Float, y:Float ) 
	{
		this.x = x;
		this.y = y;
	}
	
	public function add(v:PVector):PVector
	{		
		x += v.x;
		y += v.y;		
		return this;
	}
	
	static public function sum(v1:PVector,v2:PVector):PVector
	{		
		return new PVector(v1.x + v2.x, v1.y + v2.y);
	}	
	
	public function sub(v:PVector):PVector
	{
		x -= v.x;
		y -= v.y;		
		return this;
	}
	
	static public function subtraction(v1:PVector,v2:PVector):PVector
	{
		return new PVector(v1.x - v2.x, v1.y - v2.y);
	}
	
	public function mult(value:Float):PVector
	{		
		x *= value;
		y *= value;		
		return this;
	}
	
	static public function times(v:PVector, value:Float):PVector
	{
		return new PVector(v.x * value, v.y * value);
	}
	
	public function div(value:Float):PVector
	{
		x /= value;
		y /= value;		
		return this;
	}
	
	static public function division(v:PVector, value:Float):PVector
	{
		return new PVector(v.x / value, v.y / value);
	}
	
	public function mag():Float
	{
		return Math.sqrt(x * x + y * y);
	}
	
	public function normalize():PVector
	{
		var magnitud:Float = mag();
		if (magnitud > 0) 
		{
			return div(magnitud);
		}
		return null;
	}
	
	static public function norm(v:PVector):PVector
	{
		var magnitud:Float = v.mag();
		if (magnitud > 0) 
		{
			return division(v,magnitud);
		}
		return null;
	}
	
	public function limit(max:Float):Void
	{
		var currentMag:Float = mag();
		if (currentMag > max) 
		{
			var xProportion:Float = x / currentMag;
			var yProportion:Float = y / currentMag;
			
			x = max * xProportion;
			y = max * yProportion;
		}
	}
	
	static public function random2D():PVector
	{
		var x:Float = Math.random();
		var v:PVector = new PVector(x, 1 - x);
		var xNegative:Float = Math.random();
		var yNegative:Float = Math.random();
		if (xNegative < 0.5) 
		{
			v.x *= -1;
		}
		if (yNegative < 0.5) 
		{
			v.y *= -1;
		}
		return v;
	}
	
	public function toString():String
	{
		return "[" + x + "," + y + "]";
	}
}