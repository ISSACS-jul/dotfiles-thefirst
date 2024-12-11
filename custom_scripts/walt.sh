#!/bin/bash

exec "swww-daemon" & disown

# Carpeta donde están los fondos de pantalla
carpeta="/usr/share/backgrounds/fav/"

# Bucle infinito
while true; do
  if hyprctl clients | grep -q 'fullscreen: 2'; then
	  echo "ventana en fullscreen"
  else
    # Selecciona un archivo aleatorio de la carpeta
    archivo=$(find "$carpeta" -type f | shuf -n 1)

    # Verifica si el archivo realmente existe
    if [[ -f "$archivo" ]]; then
      # Cambia el fondo con swww
      swww img "$archivo" --transition-type random
    else
      echo "No se encontró un archivo válido en $carpeta"
    fi
  fi
  # Espera 10 minutos antes de cambiar el fondo de nuevo
  sleep 600
done
