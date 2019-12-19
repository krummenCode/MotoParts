using MotoPartsCommon;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsDAL
{
    public class UpdateRoleDAL
    {
        public bool updateRole(int UserID, int RoleIDFK)
        {
            bool result = false;

            ExceptionHandling e = new ExceptionHandling();

            string dbConnection = System.Configuration.ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            try
            {
                //establish the connection
                using (SqlConnection conn = new SqlConnection(dbConnection))
                {
                    // create command
                    using (SqlCommand command = new SqlCommand("SP_UPDATE_USER_ROLE", conn))
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandTimeout = 30;
                        conn.Open();


                        command.Parameters.AddWithValue("@parmUserID", SqlDbType.Int).Value = UserID;
                        command.Parameters.AddWithValue("@parmRoleIDFK", SqlDbType.Int).Value = RoleIDFK;


                        command.ExecuteNonQuery();
                    }

                    conn.Close();
                }

                result = true;
            }
            catch (Exception ex)
            {
                e.WriteLogger(ex);
                e.InsertLoggerToDB(ex);
            }

            return(result);
        }
    }
}
