using System.Text.Json;
using System.Text.Json.Serialization;

namespace SignalRChat.Client.Service
{
    public class BusinessService
    {
        private readonly HttpClient _httpClient;

        public BusinessService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public class BusinessServiceData
        {
            public bool is_backend_user_read { get; set; }
            public string user_uuid { get; set; }
            public int business_id { get; set; }
            public string business_name { get; set; }
            public string business_service_name { get; set; }
            public string user_name { get; set; }
            public string business_service_talks_is_not_read_count { get; set; }
        }
        public class BusinessServiceList
        {
            public BusinessServiceData[] data { get; set; }
            public int code { get; set; }
            public string message { get; set; }
        }

        public async Task<BusinessServiceList> GetBusinessServiceChatRoomList(int backendUserId)
        {
            try
            {
                var uri = "http://10.10.10.207:3000/api/businessServiceListAndIsNotReadCountBack/1";
                var response = await _httpClient.GetAsync(uri);

                if (response.IsSuccessStatusCode)
                {
                    string data = await response.Content.ReadAsStringAsync();
                    BusinessServiceList jsonData = JsonSerializer.Deserialize<BusinessServiceList>(data);

                    foreach (var businessServiceData in jsonData.data) 
                    {
                        Console.WriteLine(businessServiceData.business_name);   
                    }

                    return jsonData;
                }
            }
            catch (Exception ex) 
            {
                Console.WriteLine($"錯誤: {ex.Message}");
            }

            return new BusinessServiceList();
        }
    }
}
