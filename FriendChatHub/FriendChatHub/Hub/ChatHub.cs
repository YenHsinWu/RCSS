using Microsoft.AspNetCore.SignalR;

namespace FriendChatHub
{
    public class ChatHub : Hub
    {
        public async Task JoinGroup(string groupName, string userName)
        {
            await Groups.AddToGroupAsync(groupName, userName);
        }

        public async Task SendMessageToGroup(string groupName, string userName, string message)
        {
            string timestamp = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.ffffff");
            await Clients.Group(groupName).SendAsync("SendGroupMsg", groupName, userName, message, timestamp);
        }
    }
}
