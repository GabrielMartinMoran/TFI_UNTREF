[![codecov](https://codecov.io/gh/GabrielMartinMoran/TFI_UNTREF/branch/main/graph/badge.svg?token=1UE896UZ8A)](https://codecov.io/gh/GabrielMartinMoran/TFI_UNTREF)

# Trabajo Final Integrador - Ingenierría en Computación - UNTREF
## Controlador de encendido y consumo eléctrico

### Introducción
Dado el creciente aumento de consumo eléctrico en los últimos años tanto en hogares como establecimientos, surge la necesidad de poder reducir el gasto energético de ciertos electrodomésticos en momentos que estos no se están utilizando y aún así se encuentran encendidos. Si bien existen algunos dispositivos en el mercado que ofrecen soluciones similares o parciales a la propuesta, todos los encontrados son de software propietario, por lo cual es necesario apegarse a las funcionalidades provistas por el fabricante, sin la posibilidad de expandir o reducir estas en caso de ser necesario, o incluso modificar el hardware utilizado en la solución.

Otro de los aspectos relevantes en comparación con muchas de las opciones disponibles del mercado en cuanto a software, es la capacidad de personalizar no solamente los horarios en que funcionará cada dispositivo, sino que la manera en que notificará al usuario que el dispositivo está funcionando como se configuró (es decir se enciende o se apaga al horario esperado); si este perdió conexión; o inclusive alertas de consumo excesivo; o resúmenes de consumo en un determinado período, siendo por la misma aplicación, por algún servicio de mensajería que permita el envío de mensajes a partir de servicios externos (como bots) o via email.

### Objetivo
El objetivo de este trabajo es construir un prototipo de sistema hardware / software de licencia abierta, que permita gestionar el encendido y apagado de dispositivos electrónicos conectados a la red eléctrica hogareña o de un establecimiento. Esta gestión se realiza a través de un smart plug (o enchufe inteligente) que actúa como intermediario entre el dispositivo y el tomacorriente.

El smart plug está compuesto principalmente por un microcontrolador que sensa constantemente el consumo energético y detecta los momentos en que tiene que permitir o detener el paso de corriente al electrodoméstico alimentado por este. A su vez, posee un botón que permite encender o apagar el dispositivo sin necesidad de utilizar la aplicación de configuración y control; y un indicador led que informa el estado actual (encendido o apagado).
En cuanto a funcionalidades, se propone permitir realizar un análisis de consumo tanto de manera independiente para cada smart plug que el usuario haya configurado, como de manera conjunta para analizar el consumo real, histórico y total en distintas franjas horarias (configurable por el usuario) y poder predecir costos.

La personalización de las configuraciones de encendido y apagado es uno de los pilares principales a los que se apunta en este trabajo, permitiendo no solo configurar horarios para los distintos días de la semana, sino que permitir agregar reglas específicas para fechas puntuales que puedan adicionarse o sobrescribir la configuración estándar diaria establecida por el usuario.

Para la configuración de los dispositivos, se propone desarrollar una aplicación mobile / web que tenga una navegabilidad sencilla para facilitar a los usuarios el uso del sistema, permitiendo encender o apagar un dispositivo, visualizar para cada dispositivo el horario de último encendido o apagado, el estado actual, consultar si el dispositivo se encuentra online. La aplicación además facilita el uso de los smart plugs permitiendo establecer un alias para cada uno, iconos específicos por dispositivo, configuración de alta de dispositivo guiada paso a paso, y posibilidad de configurar custom hooks que se disparen en el encendido y/o en el apagado (por ejemplo permitir enviar un mensaje utilizando una aplicación de mensajería que permita el uso de bots de mensajería automatizados).
Para facilitar el uso del sistema a distancia en smartphones se adiciona otra funcionalidad que permite el uso de comandos de voz interpretables por Google Assistant, que otorga la posibilidad de realizar consultas y gestionar el estado de los dispositivos configurados.

Este objetivo principal puede dividirse en 3 subobjetivos, siendo estos:
- El dispositivo de hardware (o smart plug) que se conecta a la red eléctrica y enciende o apaga los electrodomésticos conectados al mismo.
- Una aplicación web y mobile para poder gestionar los dispositivos, visualizar el consumo y predecir costos.
- Una Web API que centraliza la información, los accesos a datos y la lógica de dominio.


### Director del trabajo
Claudio Aciti
