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
    public class ViewCartDAL
    {
        public List<Part> GetPartsInCart(int iUserID)
        {
            List<Part> listPartsInCart = new List<Part>();

            ExceptionHandling e = new ExceptionHandling();

            string dbConnection = System.Configuration.ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(dbConnection))
                {

                    using (SqlCommand command = new SqlCommand("SP_SELECT_USERS_CART", conn))
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandTimeout = 30;
                        conn.Open();

                        command.Parameters.AddWithValue("@parmUserID", SqlDbType.VarChar).Value = iUserID;

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                Part p = new Part();

                                p.PartID = (int)reader["PartIDFK"];
                                p.Price = (decimal)reader["PartPrice"];
                                p.PartName = reader["PartName"].ToString();
                                p.BrandName = reader["PartBrand"].ToString();
                                p.Picture = reader["Picture"].ToString();
                                p.PartQuantity = (int)reader["Quantity"];

                                listPartsInCart.Add(p);
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
            return listPartsInCart;
        }
    }
}
