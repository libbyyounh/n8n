#!/bin/bash

# --- 配置区 ---
BACKUP_DIR="./backups/$(date +%Y%m%d_%H%M%S)"
N8N_DATA_DIR="./n8n_data"
POSTGRES_CONTAINER="n8n_postgres"
POSTGRES_USER="postgres" # 如果你在 .env 里改了，请手动替换或读取
POSTGRES_DB="n8n"       # 同上

# 创建备份目录
mkdir -p "$BACKUP_DIR"

echo "🚀 开始备份流程..."

# 1. 导出数据库 (这是最安全的备份方式)
echo "📦 正在导出 PostgreSQL 数据库..."
docker exec $POSTGRES_CONTAINER pg_dump -U $POSTGRES_USER $POSTGRES_DB > "$BACKUP_DIR/db_dump.sql"

# 2. 备份宿主机文件夹 (包含 encryptionkey 和二进制数据)
echo "📂 正在备份 n8n 配置文件..."
cp -r $N8N_DATA_DIR "$BACKUP_DIR/"

# 3. 压缩备份
tar -czf "${BACKUP_DIR}.tar.gz" "$BACKUP_DIR"
rm -rf "$BACKUP_DIR"

echo "✅ 备份完成：${BACKUP_DIR}.tar.gz"
echo "-----------------------------------"
