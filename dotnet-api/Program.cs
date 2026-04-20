using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
    });
});

var app = builder.Build();

app.UseCors("AllowAll");

app.MapGet("/", () => new { message = "Hello from .NET API", version = "1.0.0" })
    .WithName("GetMessage")
    .WithOpenApi();

app.MapGet("/health", () =>
{
    var hostname = Environment.MachineName;
    return new { status = "healthy", hostname };
})
.WithName("GetHealth")
.WithOpenApi();

Console.WriteLine("ASP.NET API starting on port 8080");
app.Run("http://0.0.0.0:8080");
