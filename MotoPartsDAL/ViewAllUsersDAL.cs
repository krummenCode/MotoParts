using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using MotoPartsCommon;

namespace MotoPartsDAL
{
    public class ViewAllUsersDAL
    {

        public List<User> ViewAllUsers(User user)
        {
            List<User> listUsers = new List<User>();

            ExceptionHandling e = new ExceptionHandling();

            string dbConnection = System.Configuration.ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;
            try
            {
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
                                //u.Salt = reader["Salt"].ToString();
                                u.Email = reader["Email"].ToString();
                                u.RoleIDFK = (int)reader["RoleIDFK"];
                                listUsers.Add(u);
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
            return listUsers.ToList();
        }
    }
}
