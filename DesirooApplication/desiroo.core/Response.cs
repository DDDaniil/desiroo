namespace desiroo.core;

public class Response
{
    public Response()
    {
        Succeeded = true;
    }
    
    public Response(Error error)
    {
        Succeeded = false;
        Errors = [error.Description];
    }
    
    public Response(Error[] error)
    {
        Succeeded = false;
        Errors = error.Select(err => err.Description).ToArray();
    }
    
    public bool Succeeded { get; set; }
    public string[]? Errors { get; set; }
}