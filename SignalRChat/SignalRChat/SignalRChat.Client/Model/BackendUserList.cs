namespace SignalRChat.Client.Model
{
    public class BackendUserList
    {
        public DataBackendUserList[]? data { get; set; }
        public int dataBackendUsersCount { get; set; } = default;
        public string code { get; set; }
        public string message { get; set; }
    }
}
