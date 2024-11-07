using Microsoft.AspNetCore.SignalR;
using ClassLibrary.Service;

namespace SignalRChat.Hubs
{
    public class ChatHub : Hub
    {
        private ChatService chatService = new ChatService();

        public async Task JoinGroup(string groupName, string userName)
        {
            // Console.WriteLine($"{userName} 已加入群組 {groupName}");
            await Groups.AddToGroupAsync(Context.ConnectionId, groupName);
            await Clients.Group(groupName).SendAsync("JoinGroupMsg", 
                $"{userName} 已加入群組 {groupName}");
        }

        public async Task SendMessageToGroup(string groupName, string userName, string message, int businessId, string uuid, int backendUserId, bool isUserRead, bool isBackendUserRead)
        {
            try
            {
                await chatService.CreateServiceTalkMessage(businessId, groupName.Split('^')[0], uuid, DateTime.UtcNow,
                userName.Equals(uuid), backendUserId, message, isUserRead, isBackendUserRead);

                string timestamp = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.ffffff");

                await Clients.Group(groupName).SendAsync("SendGroupMsg", groupName, userName, message, timestamp);
            }
            catch (Exception ex) 
            {
                Console.WriteLine($"錯誤: {ex.Message}");
            }
            // Console.WriteLine($"[{groupName}] --- {userName}: {message}");
            
        }
    }
}
