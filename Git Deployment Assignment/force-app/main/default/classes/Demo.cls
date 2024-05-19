public class Demo {
    public static void printData(){
        List<String> nameList=new List<String>();
        nameList.add('Dhoni');
        nameList.add('Raina');
        nameList.add('Kohli');
        nameList.add('Rohit');
        System.debug(nameList);
        System.debug(nameList.size());
        System.debug(nameList[1]);
         Set<String> nameSet=new Set<String>();
        nameSet.add('Dhoni');
        nameSet.add('Raina');
        nameSet.add('Kohli');
        nameSet.add('Rohit');
        System.debug(nameSet);
        System.debug(nameSet.size());
        System.debug(nameSet);
        
        Map<Integer,String> map1=new Map<Integer,String>();
        map1.put(7,'Dhoni');
         map1.put(3,'Raina');
         map1.put(18,'Kohli');
         map1.put(45,'Rohit');
         map1.put(8,'Jadeja');
        System.debug(map1);
        System.debug(map1.get(3));
        if(map1.containsKey(3))
        {
            map1.put(3,'Rutu');
        }
       
    }
}