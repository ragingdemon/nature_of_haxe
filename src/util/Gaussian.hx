package util;

class Gaussian
{
	private static var spare:Float;
	private static var isSpareReady:Bool;
	
	public function new()
	{
		isSpareReady = false;
	}
	
	public static function getGaussian(mean:Float, stdDev:Float):Float {
		if (isSpareReady) 
		{
			isSpareReady = false;
			return spare * stdDev + mean;
		}else {
			var u:Float, v:Float, s:Float;
			do {
				u = Math.random() * 2 - 1;
				v = Math.random() * 2 - 1;
				s = u * u + v * v;
			} while (s >= 1 || s == 0);
			var mul:Float = Math.sqrt(-2.0 * Math.log(s) / s);
			spare = v * mul;
			isSpareReady = true;
			return mean + stdDev * u * mul;
		}		
	}
}