namespace desiroo.core;

public class ResponseWith<T>
{
    
    protected ResponseWith()
    {
        
    }
    
    public ResponseWith(T data)
    {
        Succeeded = true;
        Data = data;
    }

    public ResponseWith(Error error)
    {
        Succeeded = false;
        Errors = [error.Description];
    }
    
    public ResponseWith(Error[] error)
    {
        Succeeded = false;
        Errors = error.Select(err => err.Description).ToArray();
    }

    public T? Data { get; set; }
    public bool Succeeded { get; set; }
    public string[]? Errors { get; set; }
}