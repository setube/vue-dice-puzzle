# 构建阶段
FROM node:20.19.0-alpine3.21 AS build
WORKDIR /app
COPY . .
RUN npm config set registry https://registry.npmmirror.com && \
  npm install && \
  npm run build

# 运行阶段
FROM svenstaro/miniserve:0.29.0-alpine AS runtime
# 设置端口
ENV MINISERVE_PORT=25418
WORKDIR /app
COPY --from=build /app/docs /app

EXPOSE 25418

CMD ["--index", "/app/index.html"]