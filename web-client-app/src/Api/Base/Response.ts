export interface IResponse {
    errors: string[] | null,
    succeeded: boolean,
}

export interface IResponseWith<T> {
    data: T | null,
    errors: string[] | null,
    succeeded: boolean,
}

export interface IPagingResponseWith<T> extends IResponseWith<T>{
    page: number,
    limit: number,
    totalRecords: number,
}
