# === Build stage ===
FROM python:3.11-alpine AS build

ENV PYTHONUNBUFFERED=1
WORKDIR /app

# 빌드에 필요한 라이브러리(헤더/컴파일러 포함)
RUN apk add --no-cache --virtual .build-deps \
    build-base \
    gcc \
    musl-dev \
    python3-dev \
    mariadb-connector-c-dev \
    jpeg-dev \
    zlib-dev

# pip 최신화 및 패키지 설치
COPY requirements.txt .
RUN pip install --upgrade pip setuptools wheel \
 && pip install --no-cache-dir -r requirements.txt

# 소스 복사
COPY . .

# === Runtime stage ===
FROM python:3.11-alpine AS runtime

ENV PYTHONUNBUFFERED=1
WORKDIR /app

# 런타임에만 필요한 라이브러리(헤더/컴파일러 제외)
RUN apk add --no-cache \
    mariadb-connector-c \
    jpeg \
    zlib

# 빌드된 파이썬 패키지 및 앱 복사
COPY --from=build /usr/local /usr/local
COPY --from=build /app /app

# 포트/명령은 상황에 맞게 수정
# EXPOSE 8000
# CMD ["gunicorn", "your_project.wsgi:application", "-b", "0.0.0.0:8000"]
