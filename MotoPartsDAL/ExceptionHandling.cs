using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Data.SqlClient;
using System.Data;
using MotoPartsCommon;

namespace MotoPartsDAL
{
    public class ExceptionHandling
    {
        public void WriteLogger(Exception ex)
        {   
            StreamWriter write = new StreamWriter(@"C:/Users/David.Krummen/Desktop/ErrorLogger.txt", true);
            //write.WriteLine("Time: " + DateTime.Now + "| StackTrace: " + ex.StackTrace + "| Message:" + ex.Message);
            // Interpolation
            write.WriteLine("Time: {0} /n " +
                "StackTrace: {1} /n " +
                " Message: {2} /n ", DateTime.Now, ex.StackTrace, ex.Message);
            write.Close();
            write.Dispose();
        }


        public void InsertLoggerToDB(Exception ex)
        {
            string dbConnection = System.Configuration.ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(dbConnection))
            {
                using (SqlCommand command = new SqlCommand("SP_INSERT_ERROR", conn))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.CommandTimeout = 30;
                    conn.Open();

                    command.Parameters.AddWithValue("@parmErrorDate", SqlDbType.VarChar).Value = DateTime.Now;
                    command.Parameters.AddWithValue("@parmStackTrace", SqlDbType.VarChar).Value = ex.StackTrace;
                    command.Parameters.AddWithValue("@parmErrorMessage", SqlDbType.VarChar).Value = ex.Message;

                    command.ExecuteNonQuery();
                }
                conn.Close();
            }
        }

        public List<Error> ViewAllErrors(Error er)
        {
            List<Error> listErrors = new List<Error>();

            ExceptionHandling e = new ExceptionHandling();

            string dbConnection = System.Configuration.ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(dbConnection))
                {
                    using (SqlCommand command = new SqlCommand("SP_SELECT_ERROR", conn))
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandTimeout = 30;
                        conn.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                Error exc = new Error();
                                exc.ErrorID = (int)reader["ErrorID"];
                                exc.ErrorDate = (DateTime)reader["ErrorDate"];
                                exc.StackTrace = reader["StackTrace"].ToString();
                                exc.Message = reader["ErrorMessage"].ToString();


                                listErrors.Add(exc);
                            }
                        }
                        command.ExecuteNonQuery();
                    }
                    conn.Close();
                }
            }
            catch (Exception x)
            {
                e.WriteLogger(x);
                e.InsertLoggerToDB(x);
            }
            return listErrors;
        }
    }
}
