using desiroo.domain.Models;

namespace desiroo.api.Models;

public class ProductResponse : Product
{
    public string PhotoUrl { get; set; }
}