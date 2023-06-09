#!/bin/bash

# Autor: Carlos Javier García Contreras
# Fecha de creación: 09/06/2023
# Descripción: Este script realiza una tarea específica en JBoss Fuse.
# Realiza depurado de un servicio en especifico 
# se requiere especificar los broker donde depurara el servicio 
# se requiere que no pida la contraseña al pasar al usuario fuse

# Definimos un array con los nombres de los brokers
brokers=("listadodebroker")

# Definimos el nombre del servicio que queremos depurar
servicio="servicio"

# Recorremos el array de brokers
for broker in "${brokers[@]}"; do

  # Imprimimos un mensaje para saber qué broker se está procesando
  echo "Procesando el broker $broker..."

  # Realizamos la conexión al broker y mostramos las estadísticas del servicio
  echo "Mostrando estadísticas del servicio $servicio en el broker $broker:"
  su - fuse -c "client fabric:container-connect $broker activemq:dstat | grep $servicio"

  # Realizamos la purga del servicio
  echo "Realizando la purga del servicio $servicio en el broker $broker:"
  su - fuse -c "client fabric:container-connect $broker activemq:purge $servicio"

  # Añade un espacio en blanco para mejor legibilidad
  echo ""
done

# Finalizamos el script
echo "Se ha completado la purga del servicio $servicio en todos los brokers."
