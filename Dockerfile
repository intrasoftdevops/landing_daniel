# ===== ETAPA 1: BUILD STAGE =====
FROM node:18-alpine AS builder

# Establece el directorio de trabajo
WORKDIR /app

# Copia solo los archivos de dependencias primero (para cache)
COPY package*.json ./

# Instala dependencias con cache optimizado
RUN npm ci --only=production && npm cache clean --force

# Copia el código fuente
COPY . .

# ===== ETAPA 2: PRODUCTION STAGE =====
FROM node:18-alpine AS production

# Instala solo lo necesario para producción
RUN apk add --no-cache dumb-init

# Crea usuario no-root para seguridad
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Establece el directorio de trabajo
WORKDIR /app

# Copia solo las dependencias de producción desde el builder
COPY --from=builder --chown=nodejs:nodejs /app/node_modules ./node_modules

# Copia el código de la aplicación
COPY --from=builder --chown=nodejs:nodejs /app ./

# Cambia al usuario no-root
USER nodejs

# Expone el puerto
EXPOSE 8080

# Usa dumb-init para manejar señales correctamente
ENTRYPOINT ["dumb-init", "--"]

# Comando para ejecutar la aplicación
CMD ["node", "server.js"] 