using System.ComponentModel.DataAnnotations;

namespace SignalRChat.Client.Model
{
    public class BusinessListCreateModel
    {
        [Required]
        public int business_type_id {  get; set; }
        [Required]
        public string business_name {  get; set; }
        [Required]
        public string email {  get; set; }
        [Required]
        public string phone {  get; set; }
        [Required]
        public string address {  get; set; }
        [Required]
        public string business_url { get; set; }
    }
}
