using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using MotoPartsCommon;
using System.Security.Cryptography;

namespace MotoPartsDAL
{
    public class LoginDAL
    {

        public List<User> LoginUser(User user)
        {
            List<User> listUser = new List<User>();
            ExceptionHandling e = new ExceptionHandling();


            // Create StringBuilded (Mutable char string) to append bytes of hashed password to
            // (Did not use String because they are not mutable)
            // Create empty salt string to store salt from User table for matched username
            StringBuilder hashed = new StringBuilder();
            string salt = "";


            string dbConnection = System.Configuration.ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            try
            {
                // Get users Salt by entered Username
                using (SqlConnection conn = new SqlConnection(dbConnection))
                {
                    using (SqlCommand command = new SqlCommand("SP_SELECT_USERS_SALT", conn))
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandTimeout = 30;
                        conn.Open();

                        command.Parameters.AddWithValue("@parmUserName", SqlDbType.VarChar).Value = user.UserName;

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                User u = new User();

                                u.Salt = reader["Salt"].ToString();

                                salt = u.Salt;
                            }
                        }
                    }
                    conn.Close();
                }
                



                // Once salt is recieved add it to User Password and hash it 
                string saltAndPassword = user.UserPassword + salt;
                

                // Take salted password then Hash with SHA256
                using (SHA256 sha256Hash = SHA256.Create())
                {
                    // ComputeHash - returns byte array  
                    byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(saltAndPassword));

                    // Convert byte array to a string   
                    for (int i = 0; i < bytes.Length; i++)
                    {
                        hashed.Append(bytes[i].ToString("x2"));// x2 is a string formatter. Prints two hexadecimal digits
                    }
                    hashed.ToString();
                }




                using (SqlConnection conn = new SqlConnection(dbConnection))
                {

                    using (SqlCommand command = new SqlCommand("SP_SELECT_USER", conn))
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandTimeout = 30;
                        conn.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                User u = new User();
                                u.UserID = (int)reader["UserID"];
                                u.FirstName = reader["FirstName"].ToString();
                                u.LastName = reader["LastName"].ToString();
                                u.UserName = reader["UserName"].ToString();
                                u.UserPassword = reader["UserPassword"].ToString();
                                u.Salt = reader["Salt"].ToString();
                                u.Email = reader["Email"].ToString();
                                u.RoleIDFK = (int)reader["RoleIDFK"];
                                if (reader["SavedDirtbikeIDFK"] != DBNull.Value)
                                {
                                    u.SavedDirtbikeIDFK = (int)reader["SavedDirtbikeIDFK"];
                                }
                                else{}

                                listUser.Add(u);
                            }
                        }
                    }
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                e.WriteLogger(ex);
                e.InsertLoggerToDB(ex);
            }

            // Find match of user input from list
            return listUser.Where(singleuser => singleuser.UserName == user.UserName
                    && singleuser.UserPassword == hashed.ToString()).ToList();
        }
    }
}
