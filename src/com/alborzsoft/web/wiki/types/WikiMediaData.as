package com.alborzsoft.web.wiki.types
{
	import com.alborzsoft.utils.StrUtils;
	import com.alborzsoft.utils.StringUtils;
	
	import org.hamcrest.number.isNumber;
	
	
	

	[Bindable]
	dynamic public class WikiMediaData
	{
	//=========================== VARRIABLES ==============================
		public var id:uint;
		public var name:String;
		public var image:String;
		public var caption:String;
		public var background:String;
		public var birth_name:String;
		public var alias:String;
		public var birth_place:String;
		public var death_place:String;
		public var genre:Array;
		public var occupation:Array;
		public var instruments:String;
		public var years_active:String;
		public var associated_acts:String;
		public var label:String;
		public var website:String;
		
		public var birth_date:Date
		public var death_date:Date
		public var timestamp:Date;
		
		
		

		
		public function WikiMediaData()
		{
		}
		
		
		public function set revisionText(str:String):void 
		{
			str = str.replace(/\<!\s*--(.*?)(--\s*\>)/gm, '');
			str = StringUtils.removeExtraWhitespace(str);								// removing extra white spaces
			str = str.slice(str.search(/{{Infobox musical artist/), str.search(/'''/));	// removing the BOF and EOF
			str = StrUtils.replaceAll2(str, ["{{","}}", 'Birth date and age|', 'birth date and age|', 'Death date and age|', 'death date and age|']);			//removing Extra Charachters
			
			
			
			// slicing informations to parts
			var arrInfo:Array = str.split(' | ');
			
			if(arrInfo == null)
				arrInfo = str.split(' |');
			
			if(arrInfo == null)
				arrInfo = str.split('| ');
			
			if(arrInfo){
				if(arrInfo.length == 1)
					arrInfo = str.split(' |');
				
				if(arrInfo.length == 1)
					arrInfo = str.split('| ');
				
				if(arrInfo.length == 1)
					arrInfo = str.split('|');
			}
					
			
			
			// placing the informations
			for each(var text:String in arrInfo)
			{
				text = text.replace(/<[^<]+?>/g, ''); //removing the HTML tags

				var res:Array = text.split('=');
				
				if(res.length == 2)
				{
					var value:String = res[1];
					var property:String = res[0];
					
					// fixing value
					value = StringUtils.removeExtraWhitespace(value); // removing extra white spaces
					
					
					// fixing property
					property = property.toLowerCase();
					property = StringUtils.removeExtraWhitespace(property); // removing extra white spaces
					property = StrUtils.replaceAll(property, ' ', '_'); // replaceing blank space with under line
					
					
					
					// adding values to properties
					
					if(property == 'name')
					{
						birth_name = name = value;
					}
						
					else if(property == 'genre' || property == 'occupation')
					{
						value = StrUtils.replaceAll2(value, ['[[', ']]']);
						var arr:Array = new Array;
						
						for each(var str:String in value.split(/(,|\|)/))
						{
							str = str.replace(',', '');
							str = str.replace('|', '');
							
							if(str.length) arr.push(StringUtils.removeExtraWhitespace(str));
						}
						
						this[property] = arr;
					}
						
					else if(property == 'associated_acts' || property == 'birth_place' || property == 'death_place')
					{
						value = StrUtils.replaceAll2(value, ['[[', ']]']);
						this[property] = value;
					}
						
					else if(property == 'birth_date' || property == 'Birth-date' || property == 'birth' || property == 'born')
					{
						if(StringUtils.hasText(value))
						{
							value = value.replace(/(\||)(m|d)f=(yes|no|y|n)(\||)/, '');
							var arr1:Array = value.split('|');
							birth_date = new Date(arr1[0], arr1[1]-1, arr1[2]);
						}
					}
						
					else if(property == 'death_date' || property == 'death')
					{
						if(StringUtils.hasText(value))
						{
							value = value.replace(/(\||)(m|d)f=(yes|no|y|n)(\||)/, '');
							var arr2:Array = value.split('|');
							death_date = new Date(arr2[0], arr1[1]-2, arr2[2]);
						}
					}
					
					else if(property == 'instruments' || property == 'instrument')
					{
						instruments = value;
					}
						
					else if(property == 'website')
					{
						website = value.match(/((ftp|http|https):\/\/)?((w{3}\.)|([\w-]+\.))?(([\w-])+)?\.([a-zA-Z]{2,4})\/?([\w-_&=?!\/.:%|])*/)[0]; 
					}
					
					else {
						if(StringUtils.hasText(value))
							this[property] = value;
					}
					
				}
			}
		}
		
		
		
		/** <p>dynamic url of resized image<p/>
		 * 
		 * @param width - uint of width of image
		 * @return String - the url of image with spacific size
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9, AIR 1.5
		 */
		public function imageResizedURL(width:uint=240):String
		{
			// null if there is no image
			if(image == null) return null;
			
			// making the link
			var split:Array = image.split('/');
			var fileName:String = split.pop();
			var imageTemp:String = StrUtils.replaceAll(image,
				'http://upload.wikimedia.org/wikipedia/commons/',
				'http://upload.wikimedia.org/wikipedia/commons/thumb/');
			
			imageTemp += '/' + width + 'px-' + fileName;
			
			return imageTemp;
		}
		
		
		
		
	}
		
		
}