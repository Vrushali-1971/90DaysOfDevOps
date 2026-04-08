# --- STAGE 1: THE BUILDER ---
FROM golang:1.21 AS builder
WORKDIR /app
COPY hello.go .
RUN go mod init myapp
RUN CGO_ENABLED=0 go build -o myapp .
CMD ["./myapp"]

# --- STAGE 2: THE FINAL PRODUCT ----
FROM alpine:latest
WORKDIR /root/

# Copy the binary from builder
COPY --from=builder /app/myapp .

# Create a non-root user 
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Tell Docker to switch to this user
USER appuser

# Run the app
CMD ["./myapp"]

