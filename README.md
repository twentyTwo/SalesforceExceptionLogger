# SalesforceExceptionLogger
In salesforce, the debugging is not developer-friendly, we all know. Actually it logs all the things, but the real hectic thing is to find out the expected log from tons of debug logs in the developer console.

And it is also very boring to find out the desired log from a file like this.

In this scenario, my approach is to write an exception logger/error logger to log the exceptions and critical errors in a custom object. So that, we can check the custom object to see the exception/error relation information. We can also create a trigger to notify us (send an email) when an exception occurs.
The approach is quite simple and straightforward.
I have created a custom object called Exception Logger in which I will save the exception related data.

So, I have written a class named LogException which extends the apex Exception class. Here I create five properties to hold the various data including the exception data.
public class LogException extends Exception {
    public String ModuleName {get; set;}
    public String StackTrace {get; set;}
    public String ClassName {get; set;}
    public String MethodName {get; set;}
    public String ExceptionCause {get; set;}
        
    public void log(Exception ex)
    {
     try
        {
            extractExceptionData(ex); 
            writeToObject(ex);
            System.debug('This is a debug message');            
        }
        catch(Exception e)
        {
            new LogException().Module('LogException').log(e);            
        }                 
    }
    
    public LogException Module(String Name)
    {
        ModuleName = name;
        return this;
    }
    
    public LogException ExceptionCause(String cause)
    {
        ExceptionCause = cause;
        return this;
    }
    
    public void extractExceptionData(Exception ex)
    {
        try
        {
            stackTrace = ex.getStackTraceString()
                         .substringBefore('\n');
            
            className = stackTrace.substringAfter('.')
                        .substringBefore('.'); 
            
            methodName = stackTrace.substringBefore(':')
                         .substringAfter(className)
                         .substringAfter('.');    
        }
        catch(Exception e)
        {
            new LogException().Module('LogException').log(e); 
        }                      
    }
    
    public void writeToObject(Exception ex)
    {
     try
        {
            Exception_Logger__c logger = new Exception_Logger__c();
            logger.Module_Name__c = ModuleName;
            logger.Stack_Trace__c = ex.getStackTraceString();
            logger.Class_Name__c = className;
            logger.Method_Name__c = methodName;
            logger.Line_Number__c = ex.getLineNumber();
            logger.Exception_Type__c = ex.getTypeName();
            logger.Exception_Cause_Override__c = ExceptionCause; 
            logger.Exception_Cause__c = String
                                        .valueOf(ex.getCause());
            
            logger.Exception_Message__c = ex.getMessage();
            
            insert logger;    
        }
        
        catch(Exception e)
        {
            new LogException().Module('LogException').log(e);     
        }
        
    }
    
}
You can see, I have implemented the method chaining here to make it coding friendly as the developer will use this block of code. Though, I believe the property names are self-explanatory let me briefly discuss some of the class properties and methods.
ModuleName: Actually this is an optional property. I create this to to differentiate the logs for a module of the project. For example, I have used the logger in a feature which implements the docusign functionality. In that case, I would like to set the moduleName=’Docusign’
ExtractExceptionData(): This method extracts all the necessary exception info.
Now, come to the main point. How to log the exception?
I have created a test class to depict the uses of the LogException class.
public class LogExceptionTest {
 
    public static void test1()
    {
        try
        {
           integer i = 1/0;    
        }
        catch(exception ex)
        {
            new LogException()
                .Module('unitTestModule')
                .Log(ex);
        }
    }
    
    public static void test2()
    {
        try
        {
          Account acc = [SELECT Id, Name FROM Account 
                         WHERE Name =  '7uygft6'];            
        }
        catch(exception ex)
        {
            new LogException()
                .Module('unitTestModule')
                .ExceptionCause('Probably no data in account')
                .Log(ex);
        }
        
    }
}
So, to log the exception in the custom object, one needs to have call the new LogException() with setting the optional Module and ExceptionCause in any order.
So the result is

You can see every detail here in the logger and can easily add a trigger when an exception gets inserted to the object.
Feel free to suggest changes.
