namespace SignalRChat.Client.Model
{
    public class BusinessList
    {
        public DataBusinessType[]? dataBusinessType { get; set; }
        public DataBusinessList[]? dataBusinessList { get; set; }    
        public int dataBusinessListCount { get; set; }  
        public string code { get; set; }    
        public string message { get; set; }
    }
}
