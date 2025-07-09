# 宝塔面板部署指南

本指南将帮助您在宝塔面板上部署 Next.js 项目。

## 前提条件

- 已安装宝塔面板的 Linux 服务器
- 服务器至少 2GB 内存
- 已配置域名并解析到服务器

## 第一步：服务器环境准备

### 1. 安装 Node.js

在宝塔面板中：
1. 进入「软件商店」
2. 搜索并安装「Node.js 版本管理器」
3. 安装 Node.js 18.x 版本

### 2. 安装 PostgreSQL

1. 在软件商店搜索并安装「PostgreSQL」
2. 创建数据库：
   - 数据库名：`v0_wechat_chatbot`
   - 用户名：`postgres`
   - 密码：设置一个强密码

### 3. 安装 PM2

在服务器终端执行：
```bash
npm install -g pm2
```

## 第二步：项目部署

### 1. 下载项目代码

```bash
cd /www/wwwroot
git clone https://github.com/wwwkkx/v0-wechat-chatbot.git
cd v0-wechat-chatbot
```

### 2. 安装依赖

```bash
npm install
```

### 3. 配置环境变量

```bash
cp .env.production.example .env.production
```

编辑 `.env.production` 文件，填入实际配置：

```env
# 域名配置
NEXTAUTH_URL=https://your-domain.com
NEXTAUTH_SECRET=生成一个随机字符串

# 数据库配置
DATABASE_URL=postgresql://postgres:your-password@localhost:5432/v0_wechat_chatbot

# 其他配置...
```

### 4. 初始化数据库

```bash
npx prisma generate
npx prisma migrate deploy
```

### 5. 构建项目

```bash
npm run build
```

### 6. 启动应用

```bash
pm2 start ecosystem.config.js --env production
pm2 save
```

## 第三步：配置 Nginx

### 1. 在宝塔面板添加网站

1. 进入「网站」页面
2. 点击「添加站点」
3. 填入域名
4. 选择「不创建FTP和数据库」

### 2. 配置反向代理

在网站设置中：
1. 点击「反向代理」
2. 添加反向代理：
   - 代理名称：`nextjs-app`
   - 目标URL：`http://127.0.0.1:3000`
   - 发送域名：`$host`

### 3. 配置 SSL 证书

1. 在网站设置中点击「SSL」
2. 选择「Let's Encrypt」免费证书
3. 申请并部署证书

## 第四步：配置防火墙

在宝塔面板「安全」页面：
1. 开放端口：80, 443, 22
2. 关闭不必要的端口

## 第五步：验证部署

1. 访问您的域名，检查网站是否正常运行
2. 检查 PM2 状态：
   ```bash
   pm2 status
   ```
3. 查看应用日志：
   ```bash
   pm2 logs v0-wechat-chatbot
   ```

## 自动部署（可选）

### 设置 GitHub Webhook

1. 在 GitHub 仓库设置中添加 Webhook
2. Payload URL：`https://your-domain.com/api/webhook`
3. Content type：`application/json`
4. 选择 "Just the push event"

### 创建部署脚本

在服务器上创建 `/www/wwwroot/deploy.sh`：

```bash
#!/bin/bash
cd /www/wwwroot/v0-wechat-chatbot
git pull origin main
npm install
npm run build
pm2 restart v0-wechat-chatbot
```

设置执行权限：
```bash
chmod +x /www/wwwroot/deploy.sh
```

## 常见问题

### 1. 内存不足

如果构建时出现内存不足错误：
```bash
export NODE_OPTIONS="--max-old-space-size=2048"
npm run build
```

### 2. 数据库连接失败

检查：
- PostgreSQL 服务是否运行
- 数据库连接字符串是否正确
- 防火墙设置

### 3. PM2 应用无法启动

查看详细错误：
```bash
pm2 logs v0-wechat-chatbot --lines 50
```

### 4. Nginx 502 错误

检查：
- Next.js 应用是否在 3000 端口运行
- PM2 状态是否正常
- 反向代理配置是否正确

## 性能优化

### 1. 启用 Gzip 压缩

在 Nginx 配置中添加：
```nginx
gzip on;
gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
```

### 2. 配置缓存

```nginx
location /_next/static/ {
    expires 1y;
    add_header Cache-Control "public, immutable";
}
```

### 3. 监控和日志

设置 PM2 监控：
```bash
pm2 install pm2-logrotate
pm2 set pm2-logrotate:max_size 10M
pm2 set pm2-logrotate:retain 30
```

## 维护

### 定期备份

1. 数据库备份
2. 代码备份
3. 配置文件备份

### 更新部署

```bash
cd /www/wwwroot/v0-wechat-chatbot
git pull origin main
npm install
npm run build
pm2 restart v0-wechat-chatbot
```

## 技术支持

如果遇到问题，请：
1. 检查服务器日志
2. 查看 PM2 应用状态
3. 检查 Nginx 配置
4. 验证环境变量设置

---

**注意**：请确保所有敏感信息（如数据库密码、API 密钥）都已正确配置且安全存储。
