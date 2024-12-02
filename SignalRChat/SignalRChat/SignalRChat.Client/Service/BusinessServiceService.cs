﻿using SignalRChat.Client.Model;
using SignalRChat.Client.Utility;
using System.Text;
using System.Text.Json;

namespace SignalRChat.Client.Service
{
    public class BusinessServiceService
    {
        private readonly HttpClient _httpClient;
        private readonly IConfiguration _configuration;
        public BusinessServiceService(HttpClient httpClient, IConfiguration configuration)
        {
            _httpClient = httpClient;
            _configuration = configuration;
        }
        public async Task<SignalRChat.Client.Model.BusinessServiceList> GetBusinessServiceList(string business_service_name, int business_id, int count_per_page, int page)
        {
            string err = "";
            try
            {
                var basePath = $"{_configuration["BaseUri"]}businessServiceList";  // "http://10.10.10.207:3000/api/businessList";
                var uri = ParameterHelper.BuildUrlWithQueryStringUsingStringConcat(basePath, new Dictionary<string, string>
                {
                    { "page",page.ToString()},
                    { "count_per_page",count_per_page.ToString()},
                    { "business_id",business_id.ToString()},
                    { "business_service_name",business_service_name}
                }
                );
                var response = await _httpClient.GetAsync(uri);

                if (response.IsSuccessStatusCode)
                {
                    string data = await response.Content.ReadAsStringAsync();
                    SignalRChat.Client.Model.BusinessServiceList jsonData = JsonSerializer.Deserialize<SignalRChat.Client.Model.BusinessServiceList>(data);
                    return jsonData;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"錯誤: {ex.Message}");
                err = ex.Message;
            }
            return new SignalRChat.Client.Model.BusinessServiceList
            {
                data = null,
                code = "-1",
                message = $"錯誤: {err}"
            };
        }
        public async Task<ResponseStanderd> PostBusinessServiceList(int business_id, string business_service_name, int backend_user_id)
        {
            string err = "";
            try
            {
                var basePath = $"{_configuration["BaseUri"]}businessservicelist";  // "http://10.10.10.207:3000/api/businessList";
                var uri = basePath;
                using StringContent jsonContent = new(
                    JsonSerializer.Serialize(new
                    {
                        business_id = business_id,
                        business_service_name = business_service_name,
                        backend_user_id = backend_user_id
                    }),
                    Encoding.UTF8,
                    "application/json");
                var response = await _httpClient.PostAsync(uri, jsonContent);
                if (response.IsSuccessStatusCode)
                {
                    string data = await response.Content.ReadAsStringAsync();
                    ResponseStanderd jsonData = JsonSerializer.Deserialize<ResponseStanderd>(data);
                    return jsonData;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"錯誤: {ex.Message}");
                err = ex.Message;
            }
            return new ResponseStanderd
            {
                code = "-1",
                message = $"錯誤: {err}"
            };
        }
        public async Task<ResponseStanderd> DeleteBusinessServiceList(int business_id, string business_service_name)
        {
            string err = "";
            try
            {
                var basePath = $"{_configuration["BaseUri"]}businessservicelist/{business_id}/{business_service_name}";  // "http://10.10.10.207:3000/api/businessList";
                var uri = basePath;
                //using StringContent jsonContent = new(
                //    JsonSerializer.Serialize(new {                        
                //        business_id = business_id
                //    }),
                //    Encoding.UTF8,
                //    "application/json");
                var response = await _httpClient.DeleteAsync(uri);
                if (response.IsSuccessStatusCode)
                {
                    string data = await response.Content.ReadAsStringAsync();
                    ResponseStanderd jsonData = JsonSerializer.Deserialize<ResponseStanderd>(data);
                    return jsonData;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"錯誤: {ex.Message}");
                err = ex.Message;
            }
            return new ResponseStanderd
            {
                code = "-1",
                message = $"錯誤: {err}"
            };
        }
    }
}
