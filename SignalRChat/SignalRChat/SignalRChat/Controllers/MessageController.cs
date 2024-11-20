using FirebaseAdmin.Messaging;
using Microsoft.AspNetCore.Mvc;

namespace SignalRChat.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class MessageController : ControllerBase
    {
        [HttpPost]
        public async Task<IActionResult> SendMessageAsync([FromBody] MessageRequest request) 
        {
            var message = new Message()
            {
                Notification = new Notification 
                {
                    Title = request.Title,
                    Body = request.Body
                },
                Token = request.DeviceToken
            };

            var messaging = FirebaseMessaging.DefaultInstance;
            var result = await messaging.SendAsync(message);

            if (!string.IsNullOrEmpty(result))
            {
                return Ok("Notification sent successfully");
            }
            else 
            {
                throw new Exception("Error sending the message.");
            }
            
        }
    }

    public class MessageRequest
    {
        public string Title { get; set; }
        public string Body { get; set; }
        public string DeviceToken { get; set; }
    }
}
