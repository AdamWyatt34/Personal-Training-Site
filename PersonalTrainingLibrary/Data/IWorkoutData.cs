using PersonalTrainingLibrary.Models;

namespace PersonalTrainingLibrary.Data
{
    public interface IWorkoutData
    {
        Task<int> CreateWorkout(WorkoutModel workout);
        Task<int> DeleteWorkout(int id);
        Task<WorkoutModel> GetWorkoutById(int id);
        Task<List<WorkoutModel>> GetWorkouts();
        Task<int> UpdateWorkout(WorkoutModel workout);
    }
}