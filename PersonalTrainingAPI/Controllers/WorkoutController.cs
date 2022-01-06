using Microsoft.AspNetCore.Mvc;
using PersonalTrainingLibrary.Data;
using PersonalTrainingLibrary.Models;

namespace PersonalTrainingAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class WorkoutController : ControllerBase
    {
        private readonly IWorkoutData _workoutData;

        public WorkoutController(IWorkoutData workoutData)
        {
            _workoutData = workoutData;
        }

        [HttpGet]
        public async Task<List<WorkoutModel>> Get()
        {
            return await _workoutData.GetWorkouts();
        }

        [HttpGet("{id}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> Get(int id)
        {
            if (id == 0)
            {
                return BadRequest();
            }

            var workout = await _workoutData.GetWorkoutById(id);

            if (workout != null)
            {
                return Ok(workout);
            }
            else
            {
                return NotFound();
            }
        }

        [HttpPost]
        [ValidateModel]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Post(WorkoutModel workout)
        {
            int id = await _workoutData.CreateWorkout(workout);

            return Ok(new { Id = id });
        }

        [HttpPut]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Put([FromBody] WorkoutModel workout)
        {
            await _workoutData.UpdateWorkout(workout);

            return Ok();
        }

        [HttpDelete]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Delete(int id)
        {
            await _workoutData.DeleteWorkout(id);

            return Ok();
        }
    }
}
