using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PatPal.Models
{
    public class Animal
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Species { get; set; }
        public int Age { get; set; }

        public Animal(int id, string name, string species, int age)
        {
            Id = id;
            Name = name;
            Species = species;
            Age = age;
        }
    }
}
