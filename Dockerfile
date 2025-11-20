# -------------------------
# 1. Base Image
# -------------------------
FROM python:3.10-slim

# -------------------------
# 2. System Dependencies (OCR, PDF, Images)
# -------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    tesseract-ocr \
    poppler-utils \
    libgl1 \
    libglib2.0-0 \
    wget \
    && rm -rf /var/lib/apt/lists/*

# -------------------------
# 3. Set Workdir
# -------------------------
WORKDIR /app

# -------------------------
# 4. Install Python Packages
# -------------------------
COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r /app/requirements.txt

# -------------------------
# 5. Copy Application Code
# -------------------------
COPY app.py /app/app.py

# -------------------------
# 6. Expose Port
# -------------------------
ENV PORT=8000

# -------------------------
# 7. Start Server
# -------------------------
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "1"]
