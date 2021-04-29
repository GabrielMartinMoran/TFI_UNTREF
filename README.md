# Trabajo Final Integrador - Ingenierría en Computación - UNTREF
## Controlador de encendido y consumo eléctrico

### Objetivo
El objetivo del trabajo es construir un prototipo de dispositivo que permita gestionar el encendido y apagado programado de aparato/s electrónico/s (conectado como un intermediario entre el tomacorriente y el dispositivo conectado directamente en serie a una fase de alimentación), a la vez que recolecta datos acerca del consumo energético de los mismos (como corriente y potencia consumida) mientras estos se encuentren encendidos. Tanto para administrarlos, como para poder obtener métricas acerca del muestreo realizado por los dispositivos configurados por el usuario, este deberá darlos de alta en alguna aplicación y desde esta configurar el alias con el que se identificaran las métricas del dispositivo, hora de encendido y hora de apagado del mismo. Algunas de las métricas que podrían visualizarse son consumo en tiempo real, consumo histórico y consumo acumulado, entre otras. En primera instancia la configuración debería realizarse por bluetooth desde un smartphone, donde se establecen los parámetros para que el controlador pueda conectarse a una red WiFi, junto con el alias a utilizar. Una vez configurada la conexión, el dispositivo podrá gestionarse por completo desde una web, y este publicará las muestras obtenidas a una Web API que las centralizará y podrá a disposición de los distintos tipos de visualizaciones. Desde esta web el usuario tendrá acceso a todos los dispositivos que ha configurado de manera rápida.

### Motivación
Entre las motivaciones para realizar este trabajo se encuentra la necesidad de reducir el consumo eléctrico de dispositivos en momentos que estos no se utilicen (por ejemplo dispensers de agua durante la noche en una oficina que solo opere de día), el poder controlar y conocer el consumo de distintos dispositivos electrónicos, inclusive poder controlar el consumo de una vivienda para predecir costos. En lo personal, otra motivación surge por el querer realizar un trabajo utilizando los conocimientos adquiridos en la carrera tanto de software como de hardware, condensándolos en un dispositivo IoT con interfaz mobile / web.

### Director del trabajo
Claudio Aciti
