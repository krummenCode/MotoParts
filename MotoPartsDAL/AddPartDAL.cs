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
    public class AddPartDAL
    {
        public bool AddPart(Part iPart)
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
                    using (SqlCommand command = new SqlCommand("SP_INSERT_PART", conn))
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandTimeout = 30;
                        conn.Open();


                        command.Parameters.AddWithValue("@parmDirtBikeIDFK", SqlDbType.Int).Value = iPart.DirtBikeIDFK;
                        command.Parameters.AddWithValue("@parmPartName", SqlDbType.VarChar).Value = iPart.PartName;
                        command.Parameters.AddWithValue("@parmPicture", SqlDbType.VarChar).Value = iPart.Picture;
                        command.Parameters.AddWithValue("@parmPrice", SqlDbType.Decimal).Value = iPart.Price;
                        command.Parameters.AddWithValue("@parmPartDescription", SqlDbType.VarChar).Value = iPart.PartDescription;
                        command.Parameters.AddWithValue("@parmBrandIDFK", SqlDbType.Int).Value = iPart.BrandIDFK;
                        command.Parameters.AddWithValue("@parmCategoryIDFK", SqlDbType.Int).Value = iPart.CategoryIDFK;


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
