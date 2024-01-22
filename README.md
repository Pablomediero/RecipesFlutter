
# Flutter Recipes

Proyecto Master-Detail simple donde implementar todo lo relacionado con esta tecnología.
Necesitas un **APIKEY** de Chatgpt.

### Arquitectura
Este proyecto utiliza una Clean Architecture, busco separar la lógica en capas para mejorar la modularidad, flexibilidad y mantenibilidad.

Para la interfaz de usuario he combinado el patrón de diseño MVVM (Model-View-ViewModel).

| **Capa**              | **Función** |
| ---                   | ---       |
| **Data**             |    En esta capa, nos enfocamos en la manipulación de datos y la interacción con la capa de almacenamiento local y remoto. Floor, nuestra base de datos local, se utiliza para el almacenamiento persistente de datos, permitiendo una gestión eficiente y escalable de la información..     |
| **Di**               |    La capa de Inyección de Dependencias (DI) es esencial para proporcionar una estructura flexible y desacoplada. GetIt fue mi elección para la inyección de dependencias, proporcionando una configuración flexible y fácil de entender.    |
| **Domain**           |    La lógica de negocio se centraliza en esta capa, garantizando coherencia y claridad en la implementación.    |
| **Model**            |    Esta capa se encarga de definir los modelos de datos utilizados en la aplicación. Estos modelos actúan como representaciones estructuradas de la información que fluye a través de la aplicación, facilitando la consistencia y la comprensión de los datos en todas las capas.    |
| **Presentación**     |    La gestión de vistas se basa en el patrón MVVM, proporcionando una separación clara entre la lógica de presentación y la interfaz de usuario. Utilicé Provider para la gestión de estados, asegurando una experiencia fluida para el usuario.    |

## Librerías 
Librerias y herramientas que he utilizado en esta aplicación. 

- **Floor:** Como base de datos local, Floor garantiza un almacenamiento persistente y eficiente de datos.

- **GetIt:** Inyector de dependencias para una gestión flexible de componentes y servicios.

- **Go Router:** Simplifica la gestión de la navegación, rutas y vistas en la aplicación.

- **StreamController:** Utilizado para la gestión reactiva de datos, asegurando actualizaciones en tiempo real.

- **Provider:** Herramienta clave para la gestión eficiente de estados y la actualización reactiva de la interfaz de usuario.

- **Dio:** Para la comunicación efectiva con APIs y servicios de red, Dio facilita las operaciones HTTP.
- **Flutter Launcher Icons:** Añadí Flutter Launcher Icons para personalizar el icono de la aplicación, dándole una identidad visual única.

## Chatgpt API 

#### Ejemplo

```
  POST https://api.openai.com/v1/completions
```
#### Headers
| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| Content-Type | application/json |  
| Bearer `api_key` | `string` | **Required**. Your API key |

#### Data
| Parameter | Type     |
| :-------- | :------- | 
| `model` | `string` |  
| `prompt` | `string` | 
| `max_tokens` | `int` | 
| `temperature` | `int` | 


## Autor
El feedback es vital para aprender y mejorar.

Debatir y aportar ideas permite aprender y forjarse en el camino, puedes enviarme un mensaje a mí linkedIn.
- [Pablo Mediero](https://www.linkedin.com/in/pablo-mediero-mart%C3%ADn/)

