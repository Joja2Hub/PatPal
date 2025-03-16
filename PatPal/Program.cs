using PatPal.Contollers;
using PatPal.Models;
using PatPal.Views;


namespace PatPal
{
    internal static class Program
    {
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            // To customize application configuration such as set high DPI settings or default font,
            // see https://aka.ms/applicationconfiguration.
            ApplicationConfiguration.Initialize();
            Application.Run(new Form1());
            // ������������� ������������
            var animalController = new AnimalController();
            var ownerController = new OwnerController();

            // ���������� ������
            animalController.AddAnimal(new Animal(1, "Buddy", "Dog", 5));
            ownerController.AddOwner(new Owner(1, "John Doe", "john@example.com"));

            // ����� ������
            var animalView = new AnimalView();
            animalView.DisplayAnimals(animalController.GetAllAnimals());

        }
    }
}