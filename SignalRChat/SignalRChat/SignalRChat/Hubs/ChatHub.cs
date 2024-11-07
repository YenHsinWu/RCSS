using Microsoft.AspNetCore.SignalR;

namespace SignalRChat.Hubs
{
    public class ChatHub : Hub
    {
        public async Task JoinGroup(string groupName, string userName)
        {
            // Console.WriteLine($"{userName} 已加入群組 {groupName}");
            await Groups.AddToGroupAsync(Context.ConnectionId, groupName);
            await Clients.Group(groupName).SendAsync("JoinGroupMsg", 
                $"{userName} 已加入群組 {groupName}");
        }

        public async Task SendMessageToGroup(string groupName, string userName, string message)
        {
            // Console.WriteLine($"[{groupName}] --- {userName}: {message}");
            string timestamp = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.ffffff");

            await Clients.Group(groupName).SendAsync("SendGroupMsg", groupName, userName, message, timestamp);
        }
    }
}
