FROM public.ecr.aws/docker/library/node:24.11.1-alpine as builder
WORKDIR /app
COPY package*.json .
RUN npm install
COPY . .
RUN npm run build

FROM public.ecr.aws/nginx/nginx:alpine
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist /usr/share/nginx/html
