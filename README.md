# Salesforce Apex Exception Logger

The Salesforce Apex Exception Logger is a utility class designed to simplify the process of logging exceptions in a Salesforce custom object named `Exception_Logger__c`. This README provides guidelines on how to use this utility and includes some common use cases.

You can find more detail here at [my blog](https://salesforceable.medium.com/a-handy-error-logger-in-salesforce-to-write-the-exceptions-to-a-custom-object-2b6f79e4c0ef)

## Table of Contents
1. [Getting Started](#getting-started)
2. [Usage](#usage)
3. [Use Cases](#use-cases)
4. [Best Practices](#best-practices)
5. [Contributing](#contributing)
6. [License](#license)

## Getting Started

To use the Salesforce Apex Exception Logger in your Salesforce project, follow these steps:

1. **Add Exception_Logger__c Custom Object:**

   Ensure that you have a custom object named `Exception_Logger__c` created in your Salesforce organization. This object will store the exception log data.

2. **Copy the `LogException` Class:**

   Copy the `LogException` class provided in this repository into your Salesforce Apex classes. This class contains the utility methods for logging exceptions.

3. **Initialize the Logger:**

   Initialize an instance of the `LogException` class where you want to log exceptions.

```apex
LogException logger = new LogException();
```

## Usage

### Logging an Exception

To log an exception, simply call the `log` method on the initialized logger instance and pass the exception you want to log.

```apex
try {
    // Code that may throw an exception
} catch (Exception ex) {
    logger.log(ex);
}
```

### Adding Module Name and Exception Cause

You can specify the module name and exception cause by chaining the `Module` and `ExceptionCause` methods before calling `log`.

```apex
try {
    // Code that may throw an exception
} catch (Exception ex) {
    logger.Module('YourModuleName')
          .ExceptionCause('YourExceptionCause')
          .log(ex);
}
```

## Use Cases

Here are some common use cases for the Salesforce Apex Exception Logger:

1. **Logging Database Operations:**

   Log exceptions that occur during database operations, such as inserts, updates, or deletes.

```apex
try {
    // Database operation
} catch (Exception ex) {
    logger.Module('DatabaseOperation')
          .ExceptionCause('DatabaseError')
          .log(ex);
}
```

2. **Logging Integration Errors:**

   Log exceptions are encountered when making external API calls or integrating with other systems.

```apex
try {
    // Integration code
} catch (Exception ex) {
    logger.Module('Integration')
          .ExceptionCause('ApiError')
          .log(ex);
}
```

3. **Logging Custom Exception Handling:**

   Implement custom exception handling in your code and log exceptions with meaningful module names and causes.

```apex
try {
    // Custom exception handling
} catch (CustomException ex) {
    logger.Module('CustomHandling')
          .ExceptionCause('CustomError')
          .log(ex);
}
```

## Best Practices

To make the most out of the Salesforce Apex Exception Logger, consider the following best practices:

- Always provide meaningful module names and exception causes to help identify the context of the exception.
- Use try-catch blocks to capture and log exceptions in critical parts of your code.
- Avoid recursive logging by handling exceptions gracefully within the logger itself.
- Regularly review and analyze the logged exceptions to improve system stability.

## Contributing

Contributions to this project are welcome. If you have any suggestions, bug reports, or feature requests, please open an issue on the [GitHub repository](https://github.com/twentyTwo/SalesforceExceptionLogger/issues).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
