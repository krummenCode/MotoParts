using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsDAL
{
    public class DeletePartDAL
    {
        public bool DeletePart(int PartId)
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
                    using (SqlCommand command = new SqlCommand("SP_DELETE_PART", conn))
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandTimeout = 30;
                        conn.Open();

                        command.Parameters.AddWithValue("@parmPartID", SqlDbType.Int).Value = PartId;

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

            return (result);
        }
    }
}
