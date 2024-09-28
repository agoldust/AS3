package com.alborzsoft.string
{
	import com.alborzsoft.utils.StrUtils;

	public class Spintax
	{
		
		public static function spin(text:String):String
		{
			// getting text and sping group texts
			var regExp:RegExp = /{.+?}/g;
			var text_groups:Array = text.split(regExp);
			var spin_groups:Array = text.match(regExp);
			
			
			
			// collecting the spins
			var spins:Array = new Array;

			for each (var s:String in spin_groups) 
			{
				s = s.slice(1, s.length-1); // removing the { } from sides
				spins.push(s.split('|')); // splitting the string to spins by pipeline charachter
			}
			
			
			// generating the random text
			var result:String = text_groups[0];

			for(var i:int = 0; i<text_groups.length; i++) 
			{
				if(i >= spins.length) break; //break if there is no spin on current index
				
				result += spins[i][int(Math.random()*spins[i].length)] + text_groups[i+1];
			}
			
			/*
			if(result.search('{') > -1)
				result = spin(result);
			*/
			return result;
		}
		
		
	}
}