using Dapper;
using PersonalTrainingLibrary.Database;
using PersonalTrainingLibrary.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PersonalTrainingLibrary.Data
{
    public class ClientData : IClientData
    {
        private readonly IDataAccess _dataAccess;
        private readonly ConnectionStringData _connectionString;

        public ClientData(IDataAccess dataAccess, ConnectionStringData connectionString)
        {
            _dataAccess = dataAccess;
            _connectionString = connectionString;
        }

        public async Task<int> CreateClient(ClientModel client)
        {
            DynamicParameters p = new();

            p.Add("FirstName", client.FirstName);
            p.Add("LastName", client.LastName);
            p.Add("EmailAddress", client.EmailAddress);
            p.Add("PhoneNumber", client.PhoneNumber);
            p.Add("DateOfBirth", client.DateOfBirth);
            p.Add("Id", DbType.Int32, direction: ParameterDirection.Output);

            await _dataAccess.SaveData("dbo.spClients_Create", p, _connectionString.SqlConnectionName);

            return p.Get<int>("Id");
        }

        public async Task<int> UpdateClient(ClientModel client)
        {
            return await _dataAccess.SaveData("dbo.spClients_Update",
            new
            {
                Id = client.Id,
                FirstName = client.FirstName,
                LastName = client.LastName,
                EmailAddress = client.EmailAddress,
                PhoneNumber = client.PhoneNumber,
                DateOfBirth = client.DateOfBirth
            },
            _connectionString.SqlConnectionName);
        }

        public async Task<int> DeleteClient(int id)
        {
            return await _dataAccess.SaveData("dbo.spClients_Delete",
                                              new { Id = id },
                                              _connectionString.SqlConnectionName);
        }

        public async Task<List<ClientModel>> GetClients()
        {
            return await _dataAccess.LoadData<ClientModel, dynamic>("dbo.spClients_All",
                                                                    new { },
                                                                    _connectionString.SqlConnectionName);
        }

        public async Task<ClientModel> GetClientById(int id)
        {
            var recs = await _dataAccess.LoadData<ClientModel, dynamic>("dbo.spClients_GetById",
                                                                        new { Id = id },
                                                                        _connectionString.SqlConnectionName);

            return recs.FirstOrDefault();
        }
    }
}
