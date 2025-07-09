# V0 微信聊天机器人

基于Next.js的微信聊天机器人项目，支持Notion集成和AI对话功能。

## 功能特性

- 🤖 AI对话功能（基于DeepSeek API）
- 📝 Notion集成，支持笔记管理
- 🔐 多种OAuth登录方式（Google、微信、Instagram）
- 💬 聊天会话管理
- 📱 响应式设计，支持移动端
- 🔒 安全的用户认证系统

## 技术栈

- **前端**: Next.js 15, React 19, TypeScript
- **样式**: Tailwind CSS, Radix UI
- **数据库**: PostgreSQL + Prisma ORM
- **认证**: NextAuth.js
- **AI服务**: DeepSeek API
- **部署**: 宝塔面板 + PM2

## 快速开始

### 本地开发

1. 克隆项目
```bash
git clone https://github.com/wwwkkx/v0-wechat-chatbot.git
cd v0-wechat-chatbot
```

2. 安装依赖
```bash
npm install
```

3. 配置环境变量
```bash
cp .env.local.example .env.local
# 编辑 .env.local 文件，填入相应的配置
```

4. 初始化数据库
```bash
npx prisma generate
npx prisma migrate dev
```

5. 启动开发服务器
```bash
npm run dev
```

### 生产部署

详细的宝塔面板部署指南请参考 [宝塔部署README.md](./宝塔部署README.md)

## 环境变量配置

项目需要配置以下环境变量：

- `NEXTAUTH_URL`: 应用的完整URL
- `NEXTAUTH_SECRET`: NextAuth.js密钥
- `DATABASE_URL`: PostgreSQL数据库连接字符串
- `DEEPSEEK_API_KEY`: DeepSeek AI API密钥
- `NOTION_API_KEY`: Notion集成API密钥
- `NOTION_DATABASE_ID`: Notion数据库ID
- OAuth提供商的客户端ID和密钥

详细配置请参考 `.env.production.example` 文件。

## 项目结构

```
├── app/                 # Next.js App Router
├── components/          # React组件
├── lib/                # 工具函数和配置
├── prisma/             # 数据库模式和迁移
├── public/             # 静态资源
├── 宝塔部署文档/        # 部署相关文档
└── ...
```

## 贡献

欢迎提交Issue和Pull Request！

## 许可证

MIT License
