# Step 1: Build the app
FROM elixir:1.14-alpine AS build

# Install dependencies
RUN apk add --no-cache build-base npm git
RUN mix local.hex --force && mix local.rebar --force

# Set the working directory
WORKDIR /app

# Copy mix.exs files and fetch dependencies
COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile
# Copy the rest of the application code
COPY . .

# Compile the Phoenix app
RUN mix do compile, phx.digest

# Step 2: Set up the production environment
FROM elixir:1.14-alpine AS app

# Set the working directory
WORKDIR /app

# Install runtime dependencies
RUN apk add --no-cache libstdc++
RUN mix local.hex --force && mix local.rebar --force

# Copy the compiled app from the build stage
COPY --from=build /app /app

# Set environment variables (you can set these dynamically)
ENV MIX_ENV=prod

# Start the Phoenix app (replace with your own start command)
CMD ["mix", "phx.server"]

