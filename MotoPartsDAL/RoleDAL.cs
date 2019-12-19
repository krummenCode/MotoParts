using MotoPartsCommon;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsDAL
{
    public class RoleDAL
    {
        public List<Role> SelectRolesFromTable(Role iRole)
        {
            List<Role> listRoles = new List<Role>();

            ExceptionHandling e = new ExceptionHandling();

            string dbConnection = System.Configuration.ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(dbConnection))
                {
                    using (SqlCommand command = new SqlCommand("SP_SELECT_ROLE", conn))
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandTimeout = 30;
                        conn.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                Role r = new Role();
                                r.RoleID = (int)reader["RoleID"];
                                r.RoleName = reader["RoleName"].ToString();

                                listRoles.Add(r);
                            }
                        }
                        command.ExecuteNonQuery();
                    }
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                e.WriteLogger(ex);
                e.InsertLoggerToDB(ex);
            }
            return listRoles;

        }
    }
}
