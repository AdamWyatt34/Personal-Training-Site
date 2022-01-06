using PersonalTrainingLibrary.Models;

namespace PersonalTrainingLibrary.Data
{
    public interface IClientData
    {
        Task<int> CreateClient(ClientModel client);
        Task<int> DeleteClient(int id);
        Task<ClientModel> GetClientById(int id);
        Task<List<ClientModel>> GetClients();
        Task<int> UpdateClient(ClientModel client);
    }
}