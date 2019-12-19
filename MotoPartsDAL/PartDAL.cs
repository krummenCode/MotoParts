using MotoPartsCommon;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsDAL
{
    public class PartDAL
    {

        public List<Part> SelectPart(Part iPart)
        {
            List<Part> partList = new List<Part>();

            ExceptionHandling e = new ExceptionHandling();

            string dbConnection = System.Configuration.ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(dbConnection))
                {
                    using (SqlCommand command = new SqlCommand("SP_SELECT_PART", conn))
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandTimeout = 30;
                        conn.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                Part p = new Part();
                                p.PartID = (int)reader["PartID"];
                                p.DirtBikeIDFK = (int)reader["DirtBikeIDFK"];
                                p.PartName = reader["PartName"].ToString();
                                p.Picture = reader["Picture"].ToString();
                                p.Price = (decimal)reader["Price"];
                                p.PartDescription = reader["PartDescription"].ToString();
                                p.BrandIDFK = (int)reader["BrandIDFK"];
                                p.BrandName = reader["BrandName"].ToString();
                                p.CategoryIDFK = (int)reader["CategoryIDFK"];

                                partList.Add(p);
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
            return partList;

        }
    }
}
