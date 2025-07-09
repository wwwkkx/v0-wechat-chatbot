#!/bin/bash

# 宝塔面板部署脚本
# 使用方法: chmod +x deploy.sh && ./deploy.sh

echo "开始部署 v0-wechat-chatbot..."

# 设置项目目录
PROJECT_DIR="/www/wwwroot/v0-wechat-chatbot"

# 进入项目目录
cd $PROJECT_DIR

echo "拉取最新代码..."
git pull origin main

echo "安装依赖..."
npm install

echo "生成 Prisma 客户端..."
npx prisma generate

echo "运行数据库迁移..."
npx prisma migrate deploy

echo "构建项目..."
npm run build

echo "重启 PM2 应用..."
pm2 restart v0-wechat-chatbot || pm2 start ecosystem.config.js --env production

echo "保存 PM2 配置..."
pm2 save

echo "部署完成！"
echo "检查应用状态:"
pm2 status

echo "查看应用日志:"
pm2 logs v0-wechat-chatbot --lines 10
