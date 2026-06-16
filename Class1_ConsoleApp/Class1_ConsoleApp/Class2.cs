using System;


//out paramaetr
class Class2
{
    public static void Main2()
    {
        int Total = 0;
        int Product = 0;
        Calculate(10, 20, out Total, out Product);
        Console.WriteLine("The given numbers Total is {0} and Product is {1}", Total, Product);
    }

    public static void Calculate(int FN, int SN, out int Addition, out int Multiply)
    {
        Addition = FN + SN;
        Multiply = FN * SN;
    }
}