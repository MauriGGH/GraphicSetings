#!/bin/bash

# Instalar dependencias necesarias
echo "Instalando dependencias necesarias..."
sudo apt-get update
sudo apt-get install -y build-essential x11-xserver-utils

# Directorio donde se encuentra este script
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Código en C que se va a compilar
cat << 'EOF' > "$script_dir/configuracion_video.c"
#include <stdio.h>
#include <stdlib.h>

void adjust_graphic_option(const char *option_name, const char *output, float value) {
    char command[256];
    snprintf(command, sizeof(command), "xrandr --output %s --set \"%s\" \"%f\"", output, option_name, value);
    system(command);
}

void adjust_brightness(const char *output, float value) {
    if (value < 0.1 || value > 1.0) {
        printf("El valor de brillo debe estar entre 0.1 y 1.0.\n");
        return;
    }
    char command[256];
    snprintf(command, sizeof(command), "xrandr --output %s --brightness %.2f", output, value);
    system(command);
}

void show_menu() {
    int choice;
    float value;
    char output[50];

    // Obtener el nombre de la salida de video
    printf("Introduce el nombre de la salida de video (ej. HDMI-1, eDP-1): ");
    scanf("%s", output);

    while (1) {
        printf("\nMenú de Opciones Gráficas\n");
        printf("1. Ajustar Brillo (0.1 - 1.0)\n");
        printf("2. Ajustar Contraste (0.5 - 1.5)\n");
        printf("3. Ajustar Saturación (0.5 - 1.5)\n");
        printf("4. Salir\n");
        printf("Selecciona una opción: ");
        scanf("%d", &choice);

        if (choice == 4) {
            break;
        }

        switch (choice) {
            case 1:
                printf("Introduce el valor de brillo (0.1 - 1.0): ");
                scanf("%f", &value);
                adjust_brightness(output, value);
                break;
            case 2:
                printf("Introduce el valor de contraste (0.5 - 1.5): ");
                scanf("%f", &value);
                if (value < 0.5 || value > 1.5) {
                    printf("Valor inválido para contraste. Debe estar entre 0.5 y 1.5.\n");
                    break;
                }
                adjust_graphic_option("Contrast", output, value);
                break;
            case 3:
                printf("Introduce el valor de saturación (0.5 - 1.5): ");
                scanf("%f", &value);
                if (value < 0.5 || value > 1.5) {
                    printf("Valor inválido para saturación. Debe estar entre 0.5 y 1.5.\n");
                    break;
                }
                adjust_graphic_option("Saturation", output, value);
                break;
            default:
                printf("Opción inválida. Por favor, selecciona una opción del menú.\n");
                break;
        }
    }
}

int main() {
    // Mostrar el menú
    show_menu();

    return 0;
}
EOF

# Compilar el programa en C
echo "Compilando el programa en C..."
gcc -o "$script_dir/configuracion_video" "$script_dir/configuracion_video.c"

# Ejecutar el programa compilado
echo "Ejecutando el programa..."
"$script_dir/configuracion_video"

