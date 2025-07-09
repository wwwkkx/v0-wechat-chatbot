module.exports = {
  apps: [
    {
      name: "v0-wechat-chatbot",
      script: "npm",
      args: "start",
      env: {
        NODE_ENV: "production",
        PORT: 3000,
        DATABASE_URL: "postgresql://postgres:262728@localhost:5432/postgres",
        NEXTAUTH_URL: "https://your-domain.com",
        NEXTAUTH_SECRET: "your-nextauth-secret"
      },
      instances: 1,
      autorestart: true,
      watch: false,
      max_memory_restart: "1G"
    }
  ]
};
