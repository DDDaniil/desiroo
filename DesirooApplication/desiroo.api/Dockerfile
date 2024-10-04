FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["desiroo.api/desiroo.api.csproj", "desiroo.api/"]
RUN dotnet restore "desiroo.api/desiroo.api.csproj"
COPY . .
WORKDIR "/src/desiroo.api"
RUN dotnet build "desiroo.api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "desiroo.api.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "desiroo.api.dll"]
