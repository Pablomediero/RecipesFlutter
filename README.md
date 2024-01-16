
# Flutter Recipes

Proyecto Master-Detail simple donde implementar todo lo relacionado con esta tecnología.
Necesitas un **APIKEY** de Chatgpt.

### Arquitectura
Este proyecto utiliza una Clean Architecture, busco separar la lógica en capas para mejorar la modularidad, flexibilidad y mantenibilidad.

Para la interfaz de usuario he combinado el patrón de diseño MVVM (Model-View-ViewModel).

| **Capa**              | **Función** |
| ---                   | ---       |
| **Data**             |    Gestión de datos.      |
| **Di**               |    Inyección de dependencias.    |
| **Domain**           |    Gestión de lógica de negocio.    |
| **Model**            |    Modelos de la aplicación.    |
| **Presentación**     |    Gestión de vistas.    |

## Librerías 
Librerias y herramientas que he utilizado en esta aplicación. 

- **Floor:** Base de datos local.

- **GetIt:** Inyector de dependencias.

- **Go Router:** Gestión de navegación, rutas y vistas.

- **StreamController:** Gestión de datos.

- **Provider:** Gestión de estados.

- **Dio:** Gestión y comunicación con API y servicios de red.

- **Flutter Launcher Icons:** Icono App.

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

