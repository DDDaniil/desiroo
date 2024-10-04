namespace desiroo.core;

public class ResultWith<T>
{
    private ResultWith(bool isSuccess, Error error, T value)
    {
        if (isSuccess && error != Error.None ||
            !isSuccess && error == Error.None)
        {
            throw new ArgumentException("Invalid error", nameof(error));
        }

        IsSuccess = isSuccess;
        Error = error;
        Value = value;
    }

    public bool IsSuccess { get; }
    public bool IsFailure  => !IsSuccess;

    public Error Error { get; }
    public T Value { get; }

    public static ResultWith<T> Failure(Error error) => new(false, error, default!);

    public static ResultWith<T> Success(T value) => new(true, Error.None, value);
}