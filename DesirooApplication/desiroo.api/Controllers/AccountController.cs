using desiroo.api.Models;
using desiroo.application.Interfaces;
using desiroo.core;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace desiroo.api.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly IJwtTokenService _jwtTokenService;
        private readonly IAccountService _accountService;

        public AccountController(IJwtTokenService jwtTokenService, IAccountService accountService)
        {
            _jwtTokenService = jwtTokenService;
            _accountService = accountService;
        }

        [HttpPost]
        public async Task<IActionResult> Login([FromBody] LoginCredentials credentials)
        {
            var validationResult = _accountService.ValidateCredentials(credentials.Email, credentials.Password);

            if (validationResult.IsFailure)
            {
                return BadRequest(new ResponseWith<string>(validationResult.Error));
            }

            var result = await _accountService.AuthorizeUser(credentials.Email, credentials.Password);

            if (result.IsFailure)
            {
                return BadRequest(new ResponseWith<string>(result.Error));
            }

            var token = _jwtTokenService.CreateToken(credentials.Email, result.Value);
            return Ok(new ResponseWith<string>(token));
        }

        [HttpPost]
        public async Task<IActionResult> Register([FromBody] RegisterCredentials credentials)
        {
            var validationResult = _accountService.ValidateCredentials(credentials.Email, credentials.Password);

            if (validationResult.IsFailure)
            {
                return BadRequest(new ResponseWith<string>(validationResult.Error));
            }

            var result = await _accountService.CreateUserAccount(credentials.Email, credentials.Password);
            if (result.IsFailure)
            {
                return BadRequest(new ResponseWith<string>(result.Error));
            }

            return Ok(new Response());
        }

        [Authorize]
        [HttpGet]
        public IActionResult GetUserInfo()
        {
            throw new NotImplementedException();
        }
    }
}