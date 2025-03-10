using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PatPal.Models
{
    public class Owner
    {
        public int Id { get; set; }
        public string FullName { get; set; }
        public string ContactInfo { get; set; }

        public Owner(int id, string fullName, string contactInfo)
        {
            Id = id;
            FullName = fullName;
            ContactInfo = contactInfo;
        }
    }
}
