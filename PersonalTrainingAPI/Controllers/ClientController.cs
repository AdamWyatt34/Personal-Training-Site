using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using PersonalTrainingLibrary.Data;
using PersonalTrainingLibrary.Models;

namespace PersonalTrainingAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ClientController : ControllerBase
    {
        private readonly IClientData _clientData;

        public ClientController(IClientData clientData)
        {
            _clientData = clientData;
        }

        [HttpGet]
        public async Task<List<ClientModel>> Get()
        {
            return await _clientData.GetClients();
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

            var client = await _clientData.GetClientById(id);

            if (client != null)
            {
                return Ok(client);
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
        public async Task<IActionResult> Post(ClientModel client)
        {
            int id = await _clientData.CreateClient(client);

            return Ok(new { Id = id });
        }

        [HttpPut]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Put([FromBody] ClientModel client)
        {
            await _clientData.UpdateClient(client);

            return Ok();
        }

        [HttpDelete]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Delete(int id)
        {
            await _clientData.DeleteClient(id);

            return Ok();
        }
    }
}
