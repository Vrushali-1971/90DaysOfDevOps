# --- STAGE 1: Build Stage (The "Kitchen") ---
# Use a slim Python image to keep the initial footprint small
FROM python:3.9-slim AS builder

# Create a directory inside the container for our application files
WORKDIR /app

# Create a virtual environment
RUN python -m venv /opt/venv

# Make sure we use the virtual environment
ENV PATH="/opt/venv/bin:$PATH"

# Copy ONLY the requirements file first to take advantage of Docker layer caching
COPY requirements.txt .

# Install dependencies into the virtual environment
RUN pip install --no-cache-dir -r requirements.txt


# --- STAGE 2: Runtime Stage (The "Dining Room") ---

# Start fresh with a new slim image to leave behind build tools and caches
FROM python:3.9-slim

# Set the working directory for the final container
WORKDIR /app

# SECURITY: Create a non-root user
RUN adduser --disabled-password devopsuser

# COPY virtual environment from the builder
COPY --from=builder /opt/venv /opt/venv

# Set the PATH so python knows where the "cooked" libraries are
ENV PATH="/opt/venv/bin:$PATH"

# Copy the app code and set ownership in one step
COPY --chown=devopsuser:devopsuser . .

# Switch User
USER devopsuser

# Inform Docker that the container will listen on port 5000 at runtime
EXPOSE 5000

# The command that starts the Flask application when the container launches
CMD ["python", "app.py"] 



