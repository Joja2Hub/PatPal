using PatPal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PatPal.Contollers
{
    public class OwnerController
    {
        private List<Owner> owners = new List<Owner>();

        public void AddOwner(Owner owner)
        {
            owners.Add(owner);
        }

        public List<Owner> GetAllOwners()
        {
            return owners;
        }
    }
}
