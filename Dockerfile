FROM python:3.10-slim

# Create a non-root user
RUN useradd --create-home appuser

# Set the working directory
WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
ENV PIP_ROOT_USER_ACTION=ignore
RUN pip install --no-cache-dir --disable-pip-version-check -r requirements.txt

# Copy the rest of the code
COPY --chown=appuser:appuser . .

# Switch to the non-root user
USER appuser

# Expose the port Streamlit uses
EXPOSE 8501

# Command to run the Streamlit app
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]