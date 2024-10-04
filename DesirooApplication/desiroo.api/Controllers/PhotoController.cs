using System.Configuration;
using Microsoft.AspNetCore.Mvc;
using Minio;
using Minio.DataModel.Args;

namespace desiroo.api.Controllers;

[Route("api/photos")]
[ApiController]
public class PhotoController(MinioClient minioClient, IConfiguration config) : ControllerBase
{
    private readonly IMinioClient _minioClient = minioClient;
    private readonly string _bucketName = config["MinioConfig:BucketName"] ?? throw new ConfigurationErrorsException();

    [HttpPost("upload")]
    public async Task<IActionResult> UploadPhoto(IFormFile photo)
    {
        if (photo.Length == 0)
        {
            return BadRequest("Invalid photo");
        }

        using Stream stream = photo.OpenReadStream();
        try
        {
            var args = new PutObjectArgs()
                .WithBucket(_bucketName)
                .WithObject(photo.FileName)
                .WithStreamData(stream)
                .WithObjectSize(stream.Length)
                .WithContentType(photo.ContentType);
            
            await _minioClient.PutObjectAsync(args);
            
            return Ok("Photo uploaded successfully");
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Failed to upload photo: {ex.Message}");
        }
    }

    [HttpGet("getByName")]
    public async Task<string> GetByName(string filename)
    {
        if (filename.Length == 0)
        {
            return "You invalid";
        }

        var args = new PresignedGetObjectArgs()
            .WithBucket(_bucketName)
            .WithObject(filename)
            .WithExpiry(3600);
        
        var response = await _minioClient.PresignedGetObjectAsync(args);

        return response;

    }
}