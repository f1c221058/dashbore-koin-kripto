# Menggunakan base image Python yang ringan
FROM python:3.11-slim

# Mengatur working directory di dalam container
WORKDIR /app

# Menginstal dependensi sistem yang mungkin dibutuhkan
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Menyalin file requirements terlebih dahulu (untuk memanfaatkan cache Docker)
COPY requirements.txt .

# Menginstal library Python
RUN pip install --no-cache-dir -r requirements.txt

# Menyalin seluruh kode aplikasi dan data (termasuk testing.csv) ke container
COPY . .

# Membuka port 8501 (port default Streamlit)
EXPOSE 8501

# Menjalankan aplikasi Streamlit saat container dimulai
ENTRYPOINT ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
