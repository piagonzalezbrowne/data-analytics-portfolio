# Proyecto 03 · Estimación de Humedad de Suelo con Random Forest

## Descripción

Modelo de machine learning desarrollado en **Kilimo** para estimar la humedad del suelo al tacto (%) a partir de datos de sensores de humedad, textura de suelo y características físicas del terreno.

El problema que resuelve: los sensores de humedad entregaban lecturas eléctricas que no son directamente comparables entre distintos tipos de suelo. Este modelo aprende la relación entre la lectura del sensor y la humedad real medida en terreno, **segmentando por tipo de suelo** (arenoso, franco, arcilloso) para mejorar la precisión de las predicciones.

## Stack técnico

- **Python** — pandas, scikit-learn, numpy, gspread
- **Google Colab** — entorno de ejecución
- **Google Sheets API** — fuente de datos y escritura de resultados
- **Random Forest Regressor** (scikit-learn)

## Pipeline

```
Google Sheets → pandas DataFrame → preprocesamiento → Random Forest → predicciones → Google Sheets
```

1. **Ingesta:** lectura de datos desde Google Sheets vía API (`gspread`)
2. **Preprocesamiento:**
   - Conversión de columnas a tipo numérico
   - One-Hot Encoding de variables categóricas (Compactación, Pedregosidad)
   - Clasificación de tipo de suelo por proporción Arena/Arcilla
3. **Modelamiento:** entrenamiento de un modelo Random Forest independiente por tipo de suelo
4. **Evaluación:** R² y RMSE sobre datos de entrenamiento
5. **Output:** predicciones escritas de vuelta a Google Sheets + fórmulas exportadas por tipo de suelo

## Resultados del modelo

| Tipo de suelo | R²     | RMSE  |
|---------------|--------|-------|
| Arenoso       | 0.8931 | 4.20  |
| Franco        | 0.8736 | 4.07  |
| Arcilloso     | 0.8982 | 3.35  |

Los tres modelos explican más del **87% de la varianza** en la humedad al tacto, con errores de predicción de entre 3 y 4 puntos porcentuales.

## Decisiones de diseño

- **Modelos separados por tipo de suelo:** la relación sensor-humedad varía según la textura del suelo; un modelo único generaba predicciones menos precisas en suelos extremos (arenosos o arcillosos).
- **Clasificación por proporción Arena/Arcilla:** permite categorizar automáticamente nuevas muestras sin intervención manual.
- **Integración con Google Sheets:** el equipo agronómico ingresaba datos de campo directamente en la hoja; el modelo leía, predecía y actualizaba la columna de humedad estimada sin requerir conocimientos de Python.

## Contexto

Desarrollado como parte del flujo de trabajo de calibración de sensores de humedad en Kilimo. Las predicciones alimentaban el modelo de balance hídrico usado para la programación de riego.
