using PatPal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PatPal.Contollers
{
    public class AnimalController
    {
        private List<Animal> animals = new List<Animal>();

        public void AddAnimal(Animal animal)
        {
            animals.Add(animal);
        }

        public List<Animal> GetAllAnimals()
        {
            return animals;
        }
    }
}
