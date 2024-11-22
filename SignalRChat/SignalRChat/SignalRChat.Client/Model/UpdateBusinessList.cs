namespace SignalRChat.Client.Model
{
    public class UpdateBusinessList
    {
        public DataBusinessType[]? dataBusinessType { get; set; }
        public UpdateDataBusinessList dataBusinessList { get; set; }    
        public string code { get; set; }    
        public string message { get; set; }
    }
}
