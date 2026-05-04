# Instrucciones de carga de datos

## Proyecto 01 · Producción Agrícola

Los datos originales del curso se descargaron como archivos CSV con valores numéricos separados por comas dentro de comillas (e.g., `"208,807,000"`), lo que causaba NULLs al importar directamente en DBeaver.

**Solución aplicada:** limpieza con Python/pandas en Google Colab antes de importar.

```python
import pandas as pd

archivos = [
    'milk_production.csv',
    'cheese_production.csv',
    'honey_production.csv',
    'yogurt_production.csv',
    'egg_production.csv',
    'coffee_production.csv',
    'state_lookup.csv'
]

for archivo in archivos:
    df = pd.read_csv(archivo)
    if 'Value' in df.columns:
        df['Value'] = df['Value'].astype(str).str.replace(',', '').str.strip()
        df['Value'] = pd.to_numeric(df['Value'], errors='coerce')
    df.to_csv(f'clean_{archivo}', index=False)
```

Luego se importaron los CSVs limpios en DBeaver con el wizard de importación (clic derecho sobre la tabla → Import Data).

---

## Proyecto 02 · E-commerce

Los datos vinieron en un archivo Excel (`.xlsx`) con 7 hojas. La tabla `dates` contenía fórmulas de Excel en lugar de valores calculados.

**Solución aplicada:** extracción con `openpyxl` usando `data_only=True`.

```python
import openpyxl
import csv
from datetime import date

wb = openpyxl.load_workbook('DSV1069-Course-Dataset.xlsx', data_only=True)

for sheet_name in wb.sheetnames:
    ws = wb[sheet_name]
    with open(f'{sheet_name}.csv', 'w', newline='') as f:
        writer = csv.writer(f)
        for row in ws.iter_rows(values_only=True):
            cleaned = []
            for cell in row:
                if isinstance(cell, date):
                    cleaned.append(cell.strftime('%Y-%m-%d'))
                else:
                    cleaned.append(cell)
            writer.writerow(cleaned)

print("CSVs generados correctamente.")
```

Luego se importaron los CSVs en DBeaver respetando el orden de dependencias de FK:
1. `items` y `users`
2. `orders`
3. `line_items` y `events`
4. `item_field_history` y `dates`
