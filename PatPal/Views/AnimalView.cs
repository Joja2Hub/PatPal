using PatPal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PatPal.Views
{
    public class AnimalView
    {
        public void DisplayAnimals(List<Animal> animals)
        {
            foreach (var animal in animals)
            {
                Console.WriteLine($"ID: {animal.Id}, Name: {animal.Name}, Species: {animal.Species}, Age: {animal.Age}");
            }
        }
    }
}
