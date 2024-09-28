package com.alborzsoft.web.share
{	
	import com.adobe.utils.StringUtil;
	import com.alborzsoft.utils.StrUtils;
	import com.alborzsoft.utils.StringUtils;
	
	import flash.net.URLRequest;

	public class Bookmark
	{
	//================================= VARRIABLES ===================================
		//--------PRIVATE		
		
		
		//--------PUBLIC
		/** Title of Sharing Item */
		public var title:String;
		
		/** URL of Sharing Item */
		public var url:String;
		
		/** Shorten URL*/
		public var shortURL:String;
		
		/** Description of Sharing Item */
		public var description:String;
		
		
		
	//================================= METHODS ===================================

		public function Bookmark(url:String='', title:String='', description:String='')
		{
			this.title = title;
			this.url = url;
			this.description = description;
		}
		
		
		public function get twitter():String 
		{
			return fs("http://twitter.com/home?status=" + url + fs(description, 120)); 
		}
		
		public function get facebook():String 
		{
			return fs("http://www.facebook.com/sharer.php?u=" + url + '&t=' + title);
		}
		
		public function get delicious():String
		{
			return fs("http://delicious.com/save?jump=yes&url=" + url + "&title=" + title + "&notes=" + description);
		}
		
		public function get digg():String
		{
			return fs("http://digg.com/submit?phase=2&url="+ url +"&title=" + title + "&bodytext=" + description + "&topic=your+topic");
		}
		
		public function get designfloat():String
		{
			return fs("http://www.designfloat.com/submit.php?url="+ url);
		}
		
		public function get google_bookmarks():String
		{
			return fs("http://www.google.com/bookmarks/mark?op=edit&bkmk="+ url +"&title=" + title + "&annotation=" + description + "&labels=your+label");
		}
		
		public function get reddit():String
		{
			return fs("http://www.reddit.com/submit?title=" + title + "&url="+ url);
		}
		
		public function get linkedin():String
		{
			return fs("http://www.linkedin.com/shareArticle?mini=true&url="+ url +"&title=" + title + "&source=your+source&summary=" + description);
		}
		
		public function get myspace():String
		{
			return fs("http://www.myspace.com/Modules/PostTo/Pages/?u="+ url +"&t=" + title);
		}
		
		public function get netvibes():String
		{
			return fs("http://www.netvibes.com/share?url="+ url +"&title=" + title);
		}
		
		public function get yahoo_bookmarks():String
		{
			return fs("http://bookmarks.yahoo.com/toolbar/savebm?u="+ url +"&d=" + description);
		}
		
		public function get stumble_upon():String
		{
			return fs("http://www.stumbleupon.com/submit?url="+ url);
		}
		
		public function get technocrati():String
		{
			return fs("http://technorati.com/faves?add="+ url);
		}
		
		public function get rss():String
		{
			return fs("http://activeden.net/feeds/users/Enabled.atom");
		}
		
		public function get mail():String
		{
			return fs("mailto:name@somedomain.com?subject=Your Subject"+ url);
		}
		
		
		
		
		
		/** <p>Fixing the String for sharing<p/>
		 * 
		 * @param str - String
		 * @param removeAndSign - Boolean of removing the & sign
		 * @param limit - int of Charachter count - <b>-1</b> is off
		 * @return String of fixed string
		 */
		private function fs(str:String, limit:int=-1):String
		{
			var ret:String = StringUtils.removeExtraWhitespace(str);
			
			// replacing the space with +
			ret = StrUtils.replaceAll(ret, ' ', '+');
			ret = StrUtils.replaceAll2(ret, [String.fromCharCode(13), '\n'], '');

			
			
			// limiting the string
			if(limit > -1)
				ret = StrUtils.fixedLengthString(ret, limit);
			
			
			ret = encodeURI(ret);
			
			return ret;
		}
	}
}