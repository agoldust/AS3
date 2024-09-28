package com.alborzsoft.air.filesystem
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.collections.ArrayList;

	public class FileUtil
	{
		private var file:File;
		
		
		
		public static const FILE_STRING:String = 'utf-8';
		
		
		public function FileUtil(file:File=null)
		{
			this.file = file;
		}
		
		public function getFiles(f:File=null, ignoredFiles:Vector.<File>=null):Array
		{
			// adding file info if there is any
			if(f) file = f;
			
			return getFilesRecursive(file.nativePath, ignoredFiles);
		}
		
		
		
		/**Getting total size of used space of a Directory or File
		 * @param file - File
		 * @param Number - total size of File or Directory*/
		public static function getTotalSize(file:File):Number
		{
			var total:Number = 0;
			var arr:Array = getFilesRecursive(file.nativePath);
			
			for each (var f:File in arr) 
				total += f.size;
				
			return total;
		}
		
		
		/**Getting All files inside a Folder*/
		public static function getFilesRecursive(fileURL:String, ignoredFiles:Vector.<File>=null):Array
		{
			//the current folder's file listing
			var file:File = new File(fileURL);
			var arrFiles:ArrayList = new ArrayList();
			arrFiles.source = file.getDirectoryListing();
			
			// making the FileList
			var fileList:Array = new Array
			
			
			// removing the ignored files
			if(ignoredFiles != null)
			{
				// removing the ignored File or filder
				for each(var ifi:File in ignoredFiles)
				{
					for each(var f2:File in arrFiles.source)
					{
						var str2:String = f2.nativePath.substr(0, ifi.nativePath.length);
						
						if(ifi.nativePath == str2)
							arrFiles.removeItem(f2);
					}
				}
			}
			
			
			//iterate and put files in the result and process the sub folders recursively.
			for each(var f:File in arrFiles.source)
			{
				if (f.isDirectory && f.name !="." && f.name !="..")
				{
					fileList.push(f); //it's a directory
					
					for each (var retf:File in getFilesRecursive(f.nativePath)) 
						fileList.push(retf)
				}
				else
					fileList.push(f); //it's a file yupeee
			}
			
			
			return fileList;
		}
		
		
		
		
		
		
		/** <p>Loading the File<p/>
		 * 
		 * @param url - Location of File
		 * @param root - Root of File that will be = root + '/' + url
		 * @return Object - Loaded File
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function loadFile(url:String, root:String='', fileType:String='utf-8'):Object
		{
			// amking file Class
			var file:File = new File(root + '/' + url);
			
			// opening the file
			var fileStream:FileStream = new FileStream;
			fileStream.open(file, FileMode.READ);
			
			
			// returnning the data
			if(fileType == FileUtil.FILE_STRING) return fileStream.readUTFBytes(file.size);
			
			
			return {};
		}
		
		
		/** <p>Called to format number to file size<p/>
		 * 
		 * @param size - Number amount of size
		 * @return size in String format, like <b>1024</b> to <b>1 KB</b>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function size(size:Number):String
		{
			var ret:String;
			size = Number(size / 1024)

			ret = String(size.toFixed(1) + " KB");
			
			if (size > 1024)
			{
				size = size / 1024;
				ret = String(size.toFixed(1) + " MB");
				
				
				if (size > 1024)
				{
					size = size / 1024;
					ret = String(size.toFixed(1) + " GB");
					
					
					if (size > 1024)
					{
						size = size / 1024;
						ret = String(size.toFixed(1) + " TB");
					}
				}
			}
			
			return ret;
		}
		
		
		
		
		
		
		/** <p>Checking files to be supported by adobe air<p/>
		 * 
		 * @param Array of Files
		 * @return Boolean - True if supported and can be viewed on Adobe AIR
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10, AIR 1.5
		 * @productversion Flex 4
		 */
		public static function supportedFiles(files:Array):Boolean
		{
			var exts:Array = ["jpg","jpeg","gif","png","bmp","mp4","m4v","flv","f4v","3gpp","mp3", "pdf"];
			
			for each(var file:File in files) 
			{
				var has:Boolean;
				
				for each(var ext:String in exts) 
					if(file.extension.toLocaleLowerCase() == ext) has = true;
				
				
				if(!has) return false;
			}
			
			return true;
		}
		
		
		
		
		
		
		
		
		
		
		
	}
}