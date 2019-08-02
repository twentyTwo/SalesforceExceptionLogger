public class LogExceptionTest {
	
    public static void test1()
    {
        try
        {
        	integer i = 1/0;    
        }
        catch(exception ex)
        {
            new LogException().Module('unitTestModule').Log(ex);
        }
        
    }
    
    public static void test2()
    {
        try
        {
        	Account acc = [SELECT Id, Name FROM Account WHERE Name = '7uygft6'];            
        }
        catch(exception ex)
        {
            new LogException().Module('unitTestModule').ExceptionCause('Probably no data in account').Log(ex);
        }
        
    }
}