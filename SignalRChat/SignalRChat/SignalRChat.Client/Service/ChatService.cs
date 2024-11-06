using System.Text.Json;

namespace SignalRChat.Client.Service
{
    public class ChatService
    {
        private readonly HttpClient _httpClient;

        public ChatService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public class RecentHistoryMessages 
        {
            public int business_id { get; set; }
            public string business_service_name { get; set; }
            public string user_uuid { get; set; }
            public DateTime created_date { get; set; }
            public bool is_user_talk { get; set; }
            public int backend_user_id { get; set; }
            public string talk_content { get; set; }
            public bool is_user_read { get; set; }
            public bool is_backend_user_read { get; set; }
            public string user_name { get; set; }
            public string backend_user_name { get; set; }
        }

        public class RecentHistoryMessagesList 
        {
            public RecentHistoryMessages[] data { get; set; }
            public int code { get; set; }
            public string message { get; set; }
        }

        public async Task<RecentHistoryMessagesList> GetRecentHistoryMessagesList(string uuid, string businessId, string serviceName) 
        {
            try
            {
                var uri = $"http://10.10.10.207:3000/api/businessServiceTalks/{uuid}/{businessId}/{serviceName}";
                var response = await _httpClient.GetAsync(uri);

                if (response.IsSuccessStatusCode)
                {
                    string data = await response.Content.ReadAsStringAsync();
                    RecentHistoryMessagesList jsonData = JsonSerializer.Deserialize<RecentHistoryMessagesList>(data);
                    Console.WriteLine(jsonData.data[0].talk_content);

                    return jsonData;
                }
            }
            catch (Exception ex) 
            {
                Console.WriteLine($"錯誤: {ex.Message}");
            }
            return new RecentHistoryMessagesList();
        }
    }
}
