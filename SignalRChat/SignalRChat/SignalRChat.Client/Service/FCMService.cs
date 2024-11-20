using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Util.Store;
using System.Threading;

namespace SignalRChat.Client.Service
{
    public class FCMService
    {
        private static readonly string FCMEndpoint = "https://fcm.googleapis.com/v1/projects/YOUR_PROJECT_ID/messages:send";

        // 使用 Firebase 服務帳戶密鑰來獲取訪問令牌
        public async Task<string> GetAccessTokenAsync(string serviceAccountJsonPath)
        {
            var credential = GoogleCredential.FromFile(serviceAccountJsonPath)
                .CreateScoped("https://www.googleapis.com/auth/firebase.messaging");

            var token = await credential.UnderlyingCredential.GetAccessTokenForRequestAsync();
            return token;
        }

        public async Task SendPushNotificationAsync(string registrationToken, string title, string body, string serviceAccountJsonPath)
        {
            var client = new HttpClient();

            // 獲取 Access Token
            var accessToken = await GetAccessTokenAsync(serviceAccountJsonPath);

            client.DefaultRequestHeaders.TryAddWithoutValidation("Authorization", $"Bearer {accessToken}");
            client.DefaultRequestHeaders.TryAddWithoutValidation("Content-Type", "application/json");

            // 構建 FCM 訊息
            var message = new
            {
                message = new
                {
                    token = registrationToken,  // 接收推播的裝置 token
                    notification = new
                    {
                        title = title,
                        body = body
                    },
                    data = new
                    {
                        custom_key = "custom_value"  // 自定義數據，可選
                    }
                }
            };

            var json = JsonConvert.SerializeObject(message);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            try
            {
                var response = await client.PostAsync(FCMEndpoint, content);
                response.EnsureSuccessStatusCode();

                var responseContent = await response.Content.ReadAsStringAsync();
                Console.WriteLine("Notification sent successfully: " + responseContent);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error sending notification: " + ex.Message);
            }
        }
    }
}
