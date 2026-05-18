# 1. ビルドステージ
FROM node:20-alpine AS ts-build
WORKDIR /ts

COPY package*.json tsconfig.json ./
RUN npm ci

COPY src/main/resources/static/ts/ ./src/main/resources/static/ts/

# トランスパイルを実行
RUN npm run build

# 2. ビルドステージ
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
COPY --from=ts-build ts/src/main/resources/static/js/ ./src/main/resources/static/js/
RUN mvn clean package -DskipTests

# 3. 実行ステージ
FROM eclipse-temurin:21-alpine
WORKDIR /app
COPY --from=build /app/target/onmusu-map-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]