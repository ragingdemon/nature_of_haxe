package util;


class Noise
{
	private var grid:Array<Array<Float>>;
	public var gridNoise:Array<Array<Float>>;
	
	public function new(width:Int, height:Int) 
	{
		//initialize gri array with ramdom values
		grid = new Array<Array<Float>>();		
		for (i in 0...width) { grid[i] = []; for (j in 0...height){grid[i][j] = Math.random();}}
		gridNoise = new Array<Array<Float>>();		
		for (i in 0...width) { gridNoise[i] = []; for (j in 0...height){gridNoise[i][j] = 0;}}
		for (i in 0...width) 
		{
			for (j in 0...height) 
			{
				gridNoise[i][j] = noiseValue(i, j);
			}
		}
	}
	
	private function noiseValue(x:Int, y:Int):Float
	{
		var neighbors:Float = 0;
		var neighborsValues:Float = 0;
		for (i in -1...2) 
		{
			var row:Int = x + i;
			if (row < 0 || row >= grid.length) 
			{
				continue;
			}
			for (j in -1...2) 
			{
				var column:Int = y + j;
				if (column < 0 || column >= grid[0].length) 
				{
					continue;
				}else {
					neighborsValues += grid[row][column];
					neighbors++;
				}		
			}
		}		
		return (neighborsValues / neighbors);
	}
}