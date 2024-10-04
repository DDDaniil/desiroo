using System.Configuration;
using desiroo.api.Models;
using desiroo.application.Interfaces;
using desiroo.core;
using desiroo.domain.Models;
using desiroo.infrastructure.Errors;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using Minio;
using Minio.DataModel;
using Minio.DataModel.Args;

namespace desiroo.api.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    [Authorize]
    public class WishlistController : ControllerBase
    {
        private readonly IWishlistService _wishlistService;
        private readonly IMinioClient _minioClient;
        private readonly string _bucketName;

        public WishlistController(IWishlistService wishlistService, MinioClient minioClient,
            IConfiguration config)
        {
            _wishlistService = wishlistService;
            _minioClient = minioClient;
            _bucketName = config["MinioConfig:BucketName"] ?? throw new ConfigurationErrorsException();
        }
        
        [HttpPost]
        public async Task<IActionResult> CreateWishlist(string name)
        {
            //TODO: нужен какой то метод на это дело
            var userId = HttpContext.User.FindFirst("userId")?.Value;

            if (userId.IsNullOrEmpty())
            {
                return BadRequest(new Response(AccountErrors.UserNotFoundError));
            }
            
            var result = await _wishlistService.CreateWishlist(name, userId!);

            if (result.IsFailure)
            {
                return Conflict(new Response(result.Error));
            }
            
            return Ok(new ResponseWith<Guid>(result.Value));
        }

        [HttpGet]
        public async Task<IActionResult> GetSubscribedWishlists()
        {
            //TODO: нужен какой то метод на это дело
            var userId = HttpContext.User.FindFirst("userId")?.Value;
            if (userId.IsNullOrEmpty())
            {
                return BadRequest(new Response(AccountErrors.UserNotFoundError));
            }

            var result = await _wishlistService.GetSubscribedWishlists(userId!);
            
            if (result.IsFailure)
            {
                return Conflict(new Response(result.Error));
            }
            
            return Ok(new ResponseWith<List<Wishlist>>(result.Value));
        }
        
        [HttpGet]
        public async Task<IActionResult> GetMyWishlists()
        {
            //TODO: нужен какой то метод на это дело
            var userId = HttpContext.User.FindFirst("userId")?.Value;
            if (userId.IsNullOrEmpty())
            {
                return BadRequest(new Response(AccountErrors.UserNotFoundError));
            }

            var result = await _wishlistService.GetOwnedWishlists(userId!);
            
            if (result.IsFailure)
            {
                return Conflict(new Response(result.Error));
            }
            
            return Ok(new ResponseWith<List<Wishlist>>(result.Value));
        }

        [HttpGet]
        public async Task<IActionResult> GetWishlistItems(string wishlistId, string? searchName, string? filterPrice, string? filterImportance)
        {
            var result = await _wishlistService.GetWishlistItems(wishlistId, searchName, filterPrice, filterImportance);

            if (result.IsFailure)
            {
                return BadRequest(new Response(result.Error));
            }

            var productList = new List<ProductResponse>();
            
            foreach (var product in result.Value)
            {
                var args = new PresignedGetObjectArgs()
                    .WithBucket(_bucketName)
                    .WithObject(product.ProductId.ToString())
                    .WithExpiry(3600);
                
                var url = await _minioClient.PresignedGetObjectAsync(args);
                
                productList.Add(new ()
                {
                    ProductId = product.ProductId,
                    Name = product.Name,
                    Link = product.Link,
                    PriceCategory = product.PriceCategory,
                    GiftImportance = product.GiftImportance,
                    WishlistId = product.WishlistId,
                    Wishlist = product.Wishlist,
                    PhotoUrl = url
                });
            }
            
            return Ok(new ResponseWith<List<ProductResponse>>(productList));
        }

        [HttpPost]
        public async Task<IActionResult> CreateProduct([FromForm] ProductCreate product)
        {
            var userId = HttpContext.User.FindFirst("userId")?.Value;
            
            if (userId.IsNullOrEmpty())
            {
                return BadRequest(new Response(AccountErrors.UserNotFoundError));
            }

            var result = await _wishlistService.CreateProduct(userId!, product.WishlistId, product.Name, product.Link,
                product.PriceCategory, product.GiftImportance);
            
            if (result.IsFailure)
            {
                return Conflict(new Response(result.Error));
            }
            
            if (product.Photo.Length == 0)
            {
                return BadRequest(new Response(WishlistErrors.PhotoNotUploadedError));
            }

            using Stream stream = product.Photo.OpenReadStream();
            try
            {
                var args = new PutObjectArgs()
                    .WithBucket(_bucketName)
                    .WithObject(result.Value.ProductId.ToString())
                    .WithStreamData(stream)
                    .WithObjectSize(stream.Length)
                    .WithContentType(product.Photo.ContentType);
            
                await _minioClient.PutObjectAsync(args);
            
                return Ok(new Response());
            }
            catch (Exception ex)
            {
                return BadRequest(new Response(WishlistErrors.PhotoUploadError));
            }
        }

        [HttpPost] public async Task<IActionResult> DeleteProduct([FromBody] ProductDelete product)
        {
            var userId = HttpContext.User.FindFirst("userId")?.Value;
            
            if (userId.IsNullOrEmpty())
            {
                return BadRequest(new Response(AccountErrors.UserNotFoundError));
            }

            var result = await _wishlistService.DeleteProduct(userId!, product.ProductId);
            
            if (result.IsFailure)
            {
                return Conflict(new Response(result.Error));
            }
            
            try
            {
                var args = new RemoveObjectArgs()
                    .WithBucket(_bucketName)
                    .WithObject(product.ProductId);
            
                await _minioClient.RemoveObjectAsync(args);
            
                return Ok(new Response());
            }
            catch (Exception ex)
            {
                return Ok(new Response());
            }
        }

        [HttpPut]
        public async Task<IActionResult> EditProduct([FromForm] ProductEdit product)
        {
            var userId = HttpContext.User.FindFirst("userId")?.Value;
            
            if (userId.IsNullOrEmpty())
            {
                return BadRequest(new Response(AccountErrors.UserNotFoundError));
            }
            
            var result = await _wishlistService.EditProduct(userId!, product.WishlistId, product.ProductId, product.Name, product.Link,
                product.PriceCategory, product.GiftImportance);
            
            if (result.IsFailure)
            {
                return Conflict(new Response(result.Error));
            }
            
            if (product.Photo.Length == 0)
            {
                return BadRequest(new Response(WishlistErrors.PhotoNotUploadedError));
            }

            using Stream stream = product.Photo.OpenReadStream();
            try
            {
                var args = new PutObjectArgs()
                    .WithBucket(_bucketName)
                    .WithObject(result.Value.ProductId.ToString())
                    .WithStreamData(stream)
                    .WithObjectSize(stream.Length)
                    .WithContentType(product.Photo.ContentType);
            
                await _minioClient.PutObjectAsync(args);
            
                return Ok(new Response());
            }
            catch (Exception ex)
            {
                return BadRequest(new Response(WishlistErrors.PhotoUploadError));
            }
        }
        
    }
}
