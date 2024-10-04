namespace desiroo.core;

public class PagingResponseWith<T> : ResponseWith<T>
{
    public int Page { get; set; }
    public int Limit { get; set; }
    public int TotalRecords { get; set; }
    
    public PagingResponseWith(T data, int pageNumber, int pageSize, int totalRecords)
    {
        Page = pageNumber;
        Limit = pageSize;
        Data = data;
        Succeeded = true;
        TotalRecords = totalRecords;
    }
}