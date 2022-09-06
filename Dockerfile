FROM mcr.microsoft.com/dotnet/sdk:6.0.100-preview.5 AS build-env
WORKDIR /app

# Copiar csproj e restaurar dependencias
COPY *.csproj ./
RUN dotnet restore

# Build da aplicacao
COPY . ./
RUN dotnet publish -c Release -o out

# Build da imagem
FROM mcr.microsoft.com/dotnet/aspnet:6.0.0-preview.5
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "SiteContagem.dll"]