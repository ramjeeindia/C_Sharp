
// Class 1: Basic C# Program Structure

using System;

// namespace collections of classes inside the system

class Class1
{
    public static void Main1()
    {
        Console.WriteLine("Hello, World!");

        System.Console.WriteLine("Output from other Class1");

        //ANOTHER METHOD TO CALL NAMESPACE  FOR COMMIT CTR+/ 
    }
}



// class 2



//using System;
//using System.Drawing;
//using System.Xml.Linq;
//using static System.Net.Mime.MediaTypeNames;
//using static System.Runtime.InteropServices.JavaScript.JSType;
////mports the System namespace, which contains basic built-in classes like Console.

//namespace PragimTech

////A namespace is used to organize code and avoid name conflicts between classes with the same name.


//{
//    class Program
//    //In C#, all executable code must be inside a class.
//    {
//        static void Main()

//            //This is the entry point of the program, meaning execution starts here.

//            //static: The method belongs to the class itself, so no object is needed to call it.
//            //void: The method does not return any value.
//            //Main: Special method name where the program begins.
//            //string[] args: Stores command-line arguments passed to the program.

//        {
//            Console.WriteLine("Hello, World!");

//            //Console comes from the System namespace.
//            //WriteLine prints text and moves the cursor to the next line.
//            //"Hello, World!" is the string/text being printed.
//        }
//    }
//}


// class 3

//using System;

//class Program 
//{ 
//    static void Main()
//    {
//        //bool b = true; // boolean data type 
//        //    Console.WriteLine(b);

//        //int i = 10;
//        //Console.WriteLine("Min = {0}",int.MinValue); //Min = -2147483648
//        //Console.WriteLine("Max = {0}", int.MaxValue); //Max = 2147483647


//        double d = 123.45;
//        Console.WriteLine(d);
//        Console.WriteLine(((int)d));

//    }

//}

//using System;

//class Program
//{
//    static void Main()
//    {
//        string name = "\"PragimTech";
//        Console.WriteLine(name); // Output: "PragimTech
//        // would print the double quote as part of the string, then \ is required

//        string linebr = "One\nTwo\nThree"; //call escape sequesnce
//        Console.WriteLine(linebr);

//        //Result will be 
//        //    One 
//        //    Two 
//        //    Three

//        string path = @"E:\SDK_Revision\SDK_2105\XML Files";
//        // @ used for path print
//        Console.WriteLine(path);

//        string paths = "E:\\SDK_Revision\\SDK_2105\\XML Files";
//        // \ symbol also used for path print another method with Verbatim string literal
//        Console.WriteLine(paths);



//    }
//}



// Class 5

//using System;
//using System.ComponentModel.Design;
//using System.Security.Cryptography;

//class Program
//{
//    static void Main()
//    {
//        int i = 10;
//        Console.WriteLine(i);  // Call Assignment operator

//        //airthmetic operator

//        int x = 10; int y = 4;
//        int result = x + y; // Addition
//        Console.WriteLine(result);

//        int n1 = 10;
//        int n2 = 20;

//        if (n1 == 10 && n2 == 20) //conditonal and &&
//        {
//            Console.WriteLine("Both Arguments n=10 and n2=20 are correct");

//        }
//        else
//        {
//            Console.WriteLine("Both Arguments n=10 and n2=20 are not correct");
//        }

//        // Conditional OR || 
//        int n3 = 10;
//        int n4 = 21;
//        if (n3 == 10 || n4 == 20)
//        {
//            Console.WriteLine("Any of Arguments n=10 or n2=20 are correct");
//        }
//        else
//        {
//            Console.WriteLine("Any of Arguments n=10 or n2=20 are not correct");
//        }


//        // ternary operator 
//        int a1 = 10;
//        bool ISNumber10;

//        if (a1 == 10)
//        {
//            ISNumber10 = true;
//        }
//        else
//        {
//            ISNumber10 = false;
//        }
//        Console.WriteLine("Number ==10 is {0}", ISNumber10);


//        // another method with ternary operator

//        int a2 = 10;
//        bool ISNumber20 = (a2 == 20) ? true : false;
//        Console.WriteLine("Number ==20 is {0}", ISNumber20);
//    }

//}



// this method is for class 6 and we are calling class 6 method in main method of program class
//using System;

//class Program1
//    {
//        static void Main()
//        {
//            Class6 obclass6 = new Class6();
//            obclass6.Program();
//        }
//    }

