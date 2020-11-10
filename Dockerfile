
# Montar servidor Nodejs

FROM node:9.4.0-alpine as client
#Crear espacio de trabajo
WORKDIR /usr/app/cliente/
#Copiar archivos json al nuevo destino
COPY cliente/package*.json ./
#ejecutar paquete con gestor npm
RUN npm install -qy
#Copiar configuracion al destino
COPY cliente/ ./
#Crear contenedor a partir del comando build
RUN npm run build


# Montar servidor Nodejs

FROM node:9.4.0-alpine
#Crear espacio de trabajo
WORKDIR /usr/app/
#Copiar archivos json al nuevo destino
COPY --from=cliente /usr/app/cliente/build/ ./cliente/build/
#Crear espacio de trabajo
WORKDIR /usr/app/servidor/
#Copiar archivos json al nuevo destino
COPY servidor/package*.json ./
#ejecutar paquete con gestor npm
RUN npm install -qy
#Copiar configuracion al destino
COPY servidor/ ./

ENV PORT 8000

EXPOSE 8000

CMD ["npm", "start"]
