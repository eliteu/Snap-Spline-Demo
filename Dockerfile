FROM registry.cn-shenzhen.aliyuncs.com/aimaker/node:20.10.0 AS builder

WORKDIR /app

COPY . .

RUN npm config set registry https://registry.npmmirror.com/

RUN yarn
RUN yarn build

FROM nginx:1.20.2

COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html
