using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using SignalRChat.Client.Service;

var builder = WebAssemblyHostBuilder.CreateDefault(args);

builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri("http://10.10.10.207:3000") });
builder.Services.AddScoped<BusinessService>();
builder.Services.AddScoped<ChatService>();

await builder.Build().RunAsync();
