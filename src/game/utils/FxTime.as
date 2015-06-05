package game.utils
{
	/**
	 * ...时间的一些处理工具类
	 * @author fox
	 */
	public class FxTime 
	{
		
		public function FxTime() 
		{
			
		}
		
		/**
		 * 将秒数，转换成 分钟：秒 的形式。 62秒->1:02
		 * @param	sc
		 * @return
		 */
		public static function secondsToMin(sc:int):String
		{
			var s:String = "";
			var min:String = "" + int(sc / 60);
			var scs:String = ""+sc % 60;
			if (scs.length==1)
			{
				scs = "0" + scs;
			}
			s = min + ":" + scs;
			return s;
		}
		
		/**
		 * 根据剩余秒数获得剩余时间字符串（如果大于1天，显示dhm，不然的话显示hms） 
		 * @param ms 毫秒数
		 * @return 
		 * 
		 */		
		public static function msToHourMinSec(ms:Number):String
		{
			var result:String="";
			ms=ms/1000;
			if(ms<=0)
			{
				result="00:00:00";
				return result;
			}
			var leftTime : Number = ms;
			var day:int=leftTime/(60*60*24);
			leftTime=leftTime%(60*60*24);
			var hour : int = leftTime / (60 * 60);
			leftTime = leftTime % (60 * 60);
			var minute : int = leftTime / 60 ;
			var second:int=leftTime % 60;
			
			var tempDay:String=day<10?"0"+day:day.toString();
			var tempHour:String=hour<10?"0"+hour:hour.toString();
			var tempMinute:String=minute<10?"0"+minute:minute.toString();
			var tempsec:String=second<10?"0"+second:second.toString();
			if(day<=0)
			{
				result =tempHour + "h:" + tempMinute+"m:"+tempsec+"s";
			}else
			{
				result=tempDay+"d:"+tempHour + "h:" + tempMinute+"m";
				
			}
			
			
			return result;
		}
		/**
		 * 根据剩余秒数获得剩余时间字符串（如果大于1天，显示dhm，不然的话显示hms） 
		 * @param ms 毫秒数
		 * @return 
		 * 
		 */		
		public static function msToHourMinSec1(ms:Number):String
		{
			var result:String="";
			ms=ms/1000;
			if(ms<=0)
			{
				result="00：00：00";
				return result;
			}
			var leftTime : Number = ms;
			var day:int=leftTime/(60*60*24);
			leftTime=leftTime%(60*60*24);
			var hour : int = leftTime / (60 * 60);
			leftTime = leftTime % (60 * 60);
			var minute : int = leftTime / 60 ;
			var second:int=leftTime % 60;
			
			var tempDay:String=day<10?"0"+day:day.toString();
			var tempHour:String=hour<10?"0"+hour:hour.toString();
			var tempMinute:String=minute<10?"0"+minute:minute.toString();
			var tempsec:String=second<10?"0"+second:second.toString();
			if(day<=0)
			{
				result =tempHour + "h：" + tempMinute+"m："+tempsec+"s";
			}else
			{
				result=tempDay+"d："+tempHour + "h：" + tempMinute+"m";
				
			}
			
			
			return result;
		}
		/**
		 * 根据毫秒数，返回相应的 年月日，时分秒
		 */
		public static function getYearMonthDateHourMinSec(ms:Number):String
		{
			var d:Date = new Date(ms);
			
			return d.fullYear+"/"+(d.month+1)+"/"+d.date+" "+getFixTime(d.hours)+":"+getFixTime(d.minutes)+":"+getFixTime(d.seconds);
		}
		
		/**
		 * 根据毫秒数，返回相应的 年月日，时分秒
		 */
		public static function getYearMonthDateHourMinSec1(ms:Number):String
		{
			var d:Date = new Date(ms);
			
			return d.fullYear+"/"+(d.month+1)+"/"+d.date+" "+getFixTime(d.hours)+"："+getFixTime(d.minutes)+"："+getFixTime(d.seconds);
		}
		public static function getFixTime(value:Number):String
		{
			var str:String=value+"";
			str=str.length>1?str:"0"+str;
			return str;
		}
	}

}