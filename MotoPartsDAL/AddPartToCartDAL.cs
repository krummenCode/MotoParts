using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsDAL
{
    public class AddPartToCartDAL
    {
        public void AddPartToCart(int UserIDFK, int PartIDFK, decimal PartPrice, string PartName, string PartBrand, string Picture)
        {

            ExceptionHandling e = new ExceptionHandling();

            int Quantity = 0;

            string dbConnection = System.Configuration.ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            try
            {
                // Grab User's specific part quantity
                // If its 0 then add part to Cart Table in DB
                // If its not 0 update part quantity: Quantity + 1
                using (SqlConnection conn = new SqlConnection(dbConnection))
                {

                    using (SqlCommand command = new SqlCommand("SP_SELECT_PART_QUANTITY", conn))
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandTimeout = 30;
                        conn.Open();

                        command.Parameters.AddWithValue("@parmUserID", SqlDbType.VarChar).Value = UserIDFK;
                        command.Parameters.AddWithValue("@parmPartID", SqlDbType.VarChar).Value = PartIDFK;

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {

                               Quantity  = (int)reader["Quantity"];

                            }
                        }
                    }
                    conn.Close();
                }

                // If part qauntity came back 0
                if (Quantity == 0)
                {
                    // Add part values to cart table
                    using (SqlConnection conn = new SqlConnection(dbConnection))
                    {
                        using (SqlCommand command = new SqlCommand("SP_INSERT_TO_CART", conn))
                        {
                            command.CommandType = System.Data.CommandType.StoredProcedure;
                            command.CommandTimeout = 30;
                            conn.Open();


                            command.Parameters.AddWithValue("@parmUserIDFK", SqlDbType.Int).Value = UserIDFK;
                            command.Parameters.AddWithValue("@parmPartIDFK", SqlDbType.Int).Value = PartIDFK;
                            command.Parameters.AddWithValue("@parmPartPrice", SqlDbType.Decimal).Value = PartPrice;
                            command.Parameters.AddWithValue("@parmPartName", SqlDbType.VarChar).Value = PartName;
                            command.Parameters.AddWithValue("@parmPartBrand", SqlDbType.VarChar).Value = PartBrand;
                            command.Parameters.AddWithValue("@parmPicture", SqlDbType.VarChar).Value = Picture;
                            command.Parameters.AddWithValue("@parmQuantity", SqlDbType.Int).Value = 1;



                            command.ExecuteNonQuery();
                        }

                        conn.Close();
                    }
                }

                // If part quantiy did not came back 0
                else
                {
                    using (SqlConnection conn = new SqlConnection(dbConnection))
                    {
                        using (SqlCommand command = new SqlCommand("SP_UPDATE_PART_QUANTITY", conn))
                        {
                            command.CommandType = System.Data.CommandType.StoredProcedure;
                            command.CommandTimeout = 30;
                            conn.Open();


                            command.Parameters.AddWithValue("@parmUserId", SqlDbType.Int).Value = UserIDFK;
                            command.Parameters.AddWithValue("@parmPartId", SqlDbType.Int).Value = PartIDFK;
                            command.Parameters.AddWithValue("@parmQuantity", SqlDbType.Int).Value = 1 + Quantity;


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
        }
    }
}
