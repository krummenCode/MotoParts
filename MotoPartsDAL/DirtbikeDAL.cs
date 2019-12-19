using MotoPartsCommon;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace MotoPartsDAL
{
    public class DirtbikeDAL
    {

        public List<Dirtbike> SelectDirtbike(Dirtbike iDirtbike)
        {
            List<Dirtbike> dirtbikeList = new List<Dirtbike>();

            ExceptionHandling e = new ExceptionHandling();

            string dbConnection = System.Configuration.ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(dbConnection))
                {
                    using (SqlCommand command = new SqlCommand("SP_SELECT_DIRTBIKE", conn))
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandTimeout = 30;
                        conn.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                Dirtbike db = new Dirtbike();
                                db.DirtBikeID = (int)reader["DirtBikeID"];
                                db.Make = reader["Make"].ToString();
                                db.MakeYear = (int)reader["MakeYear"];
                                db.Model = reader["Model"].ToString();

                                dirtbikeList.Add(db);
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
            return dirtbikeList;

        }
        

    }
}
