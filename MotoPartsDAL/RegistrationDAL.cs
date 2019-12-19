using MotoPartsCommon;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;

namespace MotoPartsDAL
{
    public class RegistrationDAL
    {

        public User CreateNewUser(User user)
        {
            
            ExceptionHandling e = new ExceptionHandling();


            string dbConnection = System.Configuration.ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            try
            {
                // Check to see if user name is already exsist in database
                string dbUsernames;
                List<string> listOfDbUsernames = new List<string>();
                using (SqlConnection conn = new SqlConnection(dbConnection))
                {

                    using (SqlCommand command = new SqlCommand("SP_SELECT_USERNAMES_FOR_REGISTRATION", conn))
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandTimeout = 30;
                        conn.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {

                                dbUsernames = reader["UserName"].ToString();

                                listOfDbUsernames.Add(dbUsernames);
                            }
                        }
                    }
                    conn.Close();
                }

                // If username already exsist
                if (listOfDbUsernames.Contains(user.UserName))
                {
                    user.UserName = "This username was taken.";
                }

                // If username does not exsist already
                else
                {
                    // Create salt with DateTime now
                    // Add salt to user password
                    // Create StringBuilded (Mutable char string) to append bytes of hashed password to (Did not use String because they are mutable)
                    user.Salt = DateTime.Now.ToString();
                    string saltAndPassword = user.UserPassword + user.Salt;
                    StringBuilder hashed = new StringBuilder();


                    // Take salted password then Hash with SHA256
                    using (SHA256 sha256Hash = SHA256.Create())
                    {
                        // ComputeHash - returns byte array  
                        byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(saltAndPassword));

                        // Convert byte array to a string   
                        for (int i = 0; i < bytes.Length; i++)
                        {
                            hashed.Append(bytes[i].ToString("x2"));
                        }
                        hashed.ToString();
                    }

                    

                    using (SqlConnection conn = new SqlConnection(dbConnection))
                    {
                        using (SqlCommand command = new SqlCommand("SP_INSERT_USER", conn))
                        {
                            command.CommandType = System.Data.CommandType.StoredProcedure;
                            command.CommandTimeout = 30;
                            conn.Open();

                            command.Parameters.AddWithValue("@parmFirstName", SqlDbType.VarChar).Value = user.FirstName;
                            command.Parameters.AddWithValue("@parmLastName", SqlDbType.VarChar).Value = user.LastName;
                            command.Parameters.AddWithValue("@parmUserName", SqlDbType.VarChar).Value = user.UserName;
                            command.Parameters.AddWithValue("@parmUserPassword", SqlDbType.VarChar).Value = hashed.ToString();
                            command.Parameters.AddWithValue("@parmSalt", SqlDbType.VarChar).Value = user.Salt;
                            command.Parameters.AddWithValue("@parmEmail", SqlDbType.VarChar).Value = user.Email;
                            command.Parameters.AddWithValue("@parmRoleIDFK", SqlDbType.Int).Value = 3;
                            command.Parameters.AddWithValue("@parmSavedDirtBikeIDFK", SqlDbType.Int).Value = DBNull.Value;

                            command.ExecuteNonQuery();
                        }
                        conn.Close();
                    }
                }
            } 
            catch (Exception ex)
            {
                e.WriteLogger(ex);
                e.InsertLoggerToDB(ex);
            }
            return user;
        }
    }
}
