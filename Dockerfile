# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file from the agent directory in the build context
# into the container at /app/requirements.txt
COPY agent/requirements.txt .

# Install any needed packages specified in requirements.txt
# --no-cache-dir: Disables the cache, which can reduce image size.
# --trusted-host pypi.python.org: Sometimes necessary in certain network environments or for older pip versions.
RUN pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt

# Copy the entire agent directory from the build context into /app/agent in the container
COPY ./agent ./agent

# Command to run the application, printing LIVEKIT_URL first
CMD ["sh", "-c", "python -m http.server ${PORT:-8080} >/dev/null 2>&1 & python agent/main.py start"] 