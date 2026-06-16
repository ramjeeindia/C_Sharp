using System;





class Program
{
    static void Main()
    {
        System.Console.WriteLine("This is another method to call");
        //System.Console.WriteLine(Class1.Main1());

        // 1. Call the method and save its text into a variable
        string classOutput = Class1.Main1();

        // 2. Print that text here in the Program class
        System.Console.WriteLine(classOutput);
    }
}



