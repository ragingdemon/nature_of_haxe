package util;
import openfl.display.Sprite;

class Mover
{
	public var location:PVector;
	public var velocity:PVector;
	public var acceleration:PVector;
	public var topspeed:Float;
	public var mass:Float;
	
	public var angle:Float;
	public var aVelocity:Float;
	public var aAcceleration:Float;
	public var sprite:Sprite;
	
	public function new(x:Float,y:Float,?mass:Float) 
	{		
		if (mass == null) 
		{
			this.mass = 1;
		}else 
		{
			this.mass = mass;
		}
		location = new PVector(x, y);
		
		velocity = new PVector(0, 0);
		acceleration = new PVector(0, 0);
		angle = 0;
		aVelocity = 0;
		aAcceleration = 0.1;
		sprite = new Sprite();
	}	

	public	function update():Void
	{		
		/*
		acceleration = PVector.random2D();
		acceleration.mult(Math.random() * 2);
		*/
		velocity.add(acceleration);
		//velocity.limit(topspeed);
		location.add(velocity);
		if (sprite != null) 
		{						
			sprite.x = location.x;
			sprite.y = location.y;
			sprite.rotation = angle;
		}
		
		aVelocity += aAcceleration;
		if (aVelocity < -1) 
		{
			aVelocity = -1;
		}else if (aVelocity > 1) 
		{
			aVelocity = 1;
		}
		//angle += aVelocity;
		angle = velocity.heading();
		//trace('velocity = $velocity, angle = $angle');
		acceleration.mult(0);
	}
	
	public function updatePolar()
	{		
		if (sprite != null) 
		{						
			sprite.x = location.x;
			sprite.y = location.y;
			sprite.rotation = angle;
		}
		aVelocity += aAcceleration;
		if (aVelocity < -1) 
		{
			aVelocity = -1;
		}else if (aVelocity > 1) 
		{
			aVelocity = 1;
		}
		angle += aVelocity;
		acceleration.mult(0);		
	}
	
	public function checkEdges(width:Float, height:Float):Void
	{
		if (location.x < 0) 
		{
			location.x = 0;
			velocity.x *= -1;
		}else if (location.x > width)
		{
			location.x = width;
			velocity.x *= -1;
		}
		if (location.y < 0)
		{
			location.y = 0;
			velocity.y *= -1;
		}else if (location.y > height) 
		{
			location.y = height;
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
	
	public function normalizeFoce(mousePosition:PVector):Void
	{
		if (mousePosition != null) 
		{
			var direction:PVector = PVector.subtraction(mousePosition, location);
			direction.normalize();			
			applyForce(direction.mult(0.2));
		}		
	}
	
	public function applyForce(force:PVector)
	{
		force = PVector.division(force, mass);
		acceleration.add(force);
	}
	
	public function isInsideLiquid(l:Liquid):Bool
	{		
		if (l == null) 
		{
			return false;
		}
		if (location.x > l.x && location.x < l.x + l.w && location.y > l.y && location.y < l.y + l.h)
		{			
			return true;
		}
		return false;
	}
	
	public function dragLiquid(l:Liquid):Void
	{
		var speedMagnitud:Float = velocity.mag();
		var dragMagnitud:Float = l.c * speedMagnitud * speedMagnitud;
		var drag:PVector = PVector.norm(velocity);
		if (drag != null) 
		{
			drag.mult(-1);
			drag.mult(dragMagnitud);
			applyForce(drag);
		}
	}
		
	/*
	public function toString():String
	{
		return "mass = " +mass + ", location = " + location;
	}
	*/
}