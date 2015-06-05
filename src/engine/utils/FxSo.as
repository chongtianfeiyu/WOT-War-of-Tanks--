package engine.utils
{
        import flash.net.SharedObject;
        
        
        public class FxSo
        {
                private static var mySo:SharedObject;
                
                
                /**
                 * 把数据保存到本地
                 * @param $dataName        要保存的对象名称
                 * @param $data                要保存的数据
                 * @param $name                参数共享对象名，返回共享对象的参照
                 * @return 
                 * 
                 */                
                public static function saveData($dataName:String,$data:Object,$name:String="localhostObj"):void
                {
                        mySo = SharedObject.getLocal($name);
                        mySo.data[$dataName] = $data;
                        //强制保存数据，flush可带时间参数，默认为0
                        mySo.flush();
                }
                
                /**
                 * 读取本地数据，如果没有该数据，返回null值
                 * @param $dataName                数据的名称
                 * @param $name                        参数共享对象名，返回共享对象的参照
                 * @return 
                 * 
                 */                
                public static function getData($dataName:String,$name:String="localhostObj"):Object
                {
                        mySo = SharedObject.getLocal($name);
                        if(mySo.data[$dataName] != null)
                        {
                                return mySo.data[$dataName];
                        }
                        return null;
                }
        }
}