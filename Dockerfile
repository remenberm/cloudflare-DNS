FROM python:3.13-slim

WORKDIR /app

# 安装编译依赖（部分包可能需要）
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libmariadb-dev \
    libpq-dev \
    default-libmysqlclient-dev \
    && rm -rf /var/lib/apt/lists/*

# 复制依赖文件并安装
COPY requirements.txt .
RUN pip install --no-cache-dir --index-url https://pypi.org/simple -r requirements.txt uvicorn

# 复制项目代码
COPY . .

EXPOSE 8080

# 根据你的项目启动命令调整
CMD ["uvicorn", "app.routes.main:app", "--interface=wsgi", "--host", "0.0.0.0", "--port", "8080"]
