﻿using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaDatos
{
    public class CD_Proveedor
    {


        public List<Proveedor> Listar()
        {
            List<Proveedor> lista = new List<Proveedor>();
            using (SqlConnection oconexion = new SqlConnection(Conexion.cadena))
            {
                try
                {
                    StringBuilder query = new StringBuilder();
                    query.AppendLine("select IdProveedor ,Documento,RazonSocial ,Correo,Telefono,Estado from PROVEEDOR");
           
                    SqlCommand cmd = new SqlCommand(query.ToString(), oconexion)
                    {
                        CommandType = CommandType.Text
                    };

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {
                            lista.Add(new Proveedor()
                            {
                                IdProveedor = Convert.ToInt32(dr["IdProveedor"]),
                                Documento = dr["Documento"].ToString(),
                                RazonSocial = dr["RazonSocial"].ToString(),
                                Correo = dr["Correo"].ToString(),
                                Telefono = dr["Telefono"].ToString(),
                                Estado = Convert.ToBoolean(dr["Estado"]),

                            });



                        }

                    }
                }
                catch (Exception ex)
                {

                    lista = new List<Proveedor>();

                }
            }
            return lista;
        }


        public int Registrar(Proveedor obj, out string Mensaje)
        {
            int IdProveedorgenerado = 0;
            Mensaje = string.Empty;


            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cadena))

                {

                    SqlCommand cmd = new SqlCommand("SP_RegistrarProveedor".ToString(), oconexion);

                    cmd.Parameters.AddWithValue("Documento", obj.Documento);
                    cmd.Parameters.AddWithValue("RazonSocial", obj.RazonSocial);
                    cmd.Parameters.AddWithValue("Correo", obj.Correo);
                    cmd.Parameters.AddWithValue("Telefono", obj.Telefono);
                    cmd.Parameters.AddWithValue("Estado", obj.Estado);

                    cmd.Parameters.Add("Resultado", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("Mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;

                    cmd.CommandType = CommandType.StoredProcedure;


                    oconexion.Open();

                    cmd.ExecuteNonQuery();

                    IdProveedorgenerado = Convert.ToInt32(cmd.Parameters["Resultado"].Value);
                    Mensaje = cmd.Parameters["Mensaje"].Value.ToString();
                }


            }
            catch (Exception ex)
            {
                IdProveedorgenerado = 0;
                Mensaje = ex.Message;
            }


            return IdProveedorgenerado;
        }


        public bool Editar(Proveedor obj, out string Mensaje)
        {
            bool Respuesta = false;
            Mensaje = string.Empty;


            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cadena))

                {

                    SqlCommand cmd = new SqlCommand("SP_ModificaProveedor".ToString(), oconexion);
                    cmd.Parameters.AddWithValue("IdProveedor", obj.IdProveedor);
                    cmd.Parameters.AddWithValue("Documento", obj.Documento);
                    cmd.Parameters.AddWithValue("RazonSocial", obj.RazonSocial);
                    cmd.Parameters.AddWithValue("Correo", obj.Correo);
                    cmd.Parameters.AddWithValue("Telefono", obj.Telefono);
                    cmd.Parameters.AddWithValue("Estado", obj.Estado);

                    cmd.Parameters.Add("Resultado", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("Mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;

                    cmd.CommandType = CommandType.StoredProcedure;


                    oconexion.Open();

                    cmd.ExecuteNonQuery();

                    Respuesta = Convert.ToBoolean(cmd.Parameters["Resultado"].Value);
                    Mensaje = cmd.Parameters["Mensaje"].Value.ToString();
                }


            }
            catch (Exception ex)
            {
                Respuesta = false;
                Mensaje = ex.Message;
            }


            return Respuesta;
        }


        public bool Eliminar(Proveedor obj, out string Mensaje)
        {
            bool Respuesta = false;
            Mensaje = string.Empty;


            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cadena))

                {

                    SqlCommand cmd = new SqlCommand("SP_EliminarProveedor".ToString(), oconexion);
                    cmd.Parameters.AddWithValue("IdProveedor", obj.IdProveedor);
                    cmd.Parameters.Add("Resultado", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("Mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;


                    oconexion.Open();

                    cmd.ExecuteNonQuery();

                    Respuesta = Convert.ToBoolean(cmd.Parameters["Resultado"].Value);
                    Mensaje = cmd.Parameters["Mensaje"].Value.ToString();
                }


            }
            catch (Exception ex)
            {
                Respuesta = false;
                Mensaje = ex.Message;
            }


            return Respuesta;
        }
    }
}

