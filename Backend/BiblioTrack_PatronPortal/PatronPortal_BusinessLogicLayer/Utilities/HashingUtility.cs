using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace PatronPortal_BusinessLogicLayer.Utlities
{
    public static  class HashingUtility
    {
        static string ComputeHash(string input)
        {

            using (SHA256 sha256 = SHA256.Create())
            {

                byte[] hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(input));


                return BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
            }
        }


            

        public static string ConvertToHash(string Input)
        {

            return ComputeHash(Input);


        }

    }
}
