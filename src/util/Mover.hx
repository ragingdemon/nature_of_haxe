package util;

class Mover
{
	public var location:PVector;
	public var velocity:PVector;
	public var acceleration:PVector;
	public var topspeed:Float;
	public var mass:Float;
	
	public function new(?location:PVector, ?velocity:PVector, ?acceleration:PVector,?mass:Float,?topspeed:Float) 
	{
		if (location == null) 
		{
			this.location = new PVector(0, 0);
		}else 
		{
			this.location = location;
		}
		if (velocity == null) 
		{
			this.velocity = new PVector(0, 0);
		}else 
		{
			this.velocity = velocity;
		}
		if (acceleration == null) 
		{
			this.acceleration = new PVector(-0.001, 0.1);
		}else 
		{
			this.acceleration = acceleration;
		}
		if (mass == null) 
		{
			this.mass = 10;
		}else 
		{
			this.mass = mass;
		}
		if (topspeed == null) 
		{
			this.topspeed = 20;
		}else 
		{
			this.topspeed = topspeed;
		}		
	}	

	public	function update():Void
	{
		/*
		acceleration = PVector.random2D();
		acceleration.mult(Math.random() * 2);
		*/
		velocity.add(acceleration);
		velocity.limit(topspeed);
		location.add(velocity);
		acceleration.mult(0);
	}
	
	public function checkEdges(width:Float, height:Float):Void
	{
		if (location.x < 0 || location.x > width) 
		{
			velocity.x *= -1;
		}
		if (location.y < 0 || location.y > height) 
		{
			velocity.y *= -1;
		}
	}
	
	public function teleportation(width:Float, height:Float, objectLength:Float):Void
	{
		var xLeft:Float = -objectLength;
		var xRight:Float = objectLength + width;
		var yUp:Float = -objectLength;
		var yDown:Float = objectLength + height;
		if (location.x < xLeft) 
		{
			location.x = xRight;
		}else if (location.x > xRight) 
		{
			location.x = xLeft;
		}		
		if (location.y < yUp) 
		{
			location.y = yDown;
		}else if (location.y > yDown) 
		{
			location.y = yUp;
		}
	}
	
	public function setAcceleration(mousePosition:PVector):Void
	{
		if (mousePosition != null) 
		{
			var direction:PVector = PVector.subtraction(mousePosition, location);
			direction.normalize();
			//acceleration = direction.mult(0.2);
			applyForce(direction.mult(0.2));
		}		
	}
	
	public function applyForce(force:PVector)
	{
		force = PVector.division(force, mass);
		acceleration.add(force);
	}
}