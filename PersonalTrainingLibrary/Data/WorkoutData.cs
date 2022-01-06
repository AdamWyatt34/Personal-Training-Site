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
    public class WorkoutData : IWorkoutData
    {
        private readonly IDataAccess _dataAccess;
        private readonly ConnectionStringData _connectionString;

        public WorkoutData(IDataAccess dataAccess, ConnectionStringData connectionString)
        {
            _dataAccess = dataAccess;
            _connectionString = connectionString;
        }

        public async Task<int> CreateWorkout(WorkoutModel workout)
        {
            DynamicParameters p = new();

            p.Add("Name", workout.Title);
            p.Add("Description", workout.Description);
            p.Add("Id", DbType.Int32, direction: ParameterDirection.Output);

            await _dataAccess.SaveData("dbo.spWorkouts_Create", p, _connectionString.SqlConnectionName);

            return p.Get<int>("Id");
        }

        public Task<int> UpdateWorkout(WorkoutModel workout)
        {
            return _dataAccess.SaveData("dbo.spWorkouts_Update", new
            {
                workout.Id,
                workout.Title,
                workout.Description
            },
            _connectionString.SqlConnectionName);
        }

        public Task<int> DeleteWorkout(int id)
        {
            return _dataAccess.SaveData("dbo.spWorkouts_Delete", new { Id = id }, _connectionString.SqlConnectionName);
        }

        public Task<List<WorkoutModel>> GetWorkouts()
        {
            return _dataAccess.LoadData<WorkoutModel, dynamic>("dbo.spWorkouts_All",
                                                               new { },
                                                               _connectionString.SqlConnectionName);
        }

        public async Task<WorkoutModel> GetWorkoutById(int id)
        {
            var recs = await _dataAccess.LoadData<WorkoutModel, dynamic>("dbo.spWorkouts_GetById", new { Id = id }, _connectionString.SqlConnectionName);

            return recs.FirstOrDefault();
        }
    }
}
