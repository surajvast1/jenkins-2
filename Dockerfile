FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy project files
COPY requirements.txt .
COPY app.py .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose Flask port
EXPOSE 5000

# Run the Flask application
CMD ["python", "app.py"]