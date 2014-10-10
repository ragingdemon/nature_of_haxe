package util;

class Attractor
{
	public var location:PVector;
	public var mass:Float;
	public var G:Float;
	
	public function new(mass:Float,x:Float, y:Float) 
	{
		this.mass = mass;
		this.location = new PVector(x, y);
		G = 0.4;
	}
	
	public function attract(m:Mover):PVector
	{
		var force:PVector = PVector.subtraction(location,m.location);
		var distance:Float = force.mag();		
		if (distance < 3) 
		{
			distance = 3;
		}else if (distance > 25) 
		{
			distance = 25;
		}
		//trace('distance = $distance');
		force.normalize();
		var strength:Float = (G * mass * m.mass) / (distance * distance);
		force.mult(strength);
		
		return force;
	}
}