# 1. Use a lightweight Python image
FROM python:3.12-slim

# 2. Set the working directory inside the container
WORKDIR /app

# 3. Copy the requirements and install them
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copy your app.py code into the container
COPY app.py .

# 5. Expose the port your app runs on
EXPOSE 5050

# 6. Command to run the Flask app
CMD ["python", "app.py"]
