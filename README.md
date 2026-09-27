# Coste3D

App iOS en SwiftUI para calcular el coste real de piezas fabricadas en impresión 3D.

Calcula:
- Material (gramos del slicer + merma)
- Electricidad (vatios × horas × €/kWh)
- Desgaste de la máquina (€/hora)
- Mano de obra (minutos de montaje, retirar soportes, lijar, etc.)
- Extras (tornillos, imanes, embalaje)
- Buffer de fallos
- Precio de venta sugerido con margen

Las tarifas se guardan en el iPhone para no tener que escribirlas cada vez.

## Cómo abrirla en Xcode

Hace falta un Mac con Xcode.

1. Clona el repositorio:
   `git clone https://github.com/amarnie30-dotcom/Coste3D.git`
2. Abre Xcode → **File → New → Project**
3. Elige **iOS → App**
4. Product Name: `Coste3D`
5. Interface: **SwiftUI** · Language: **Swift**
6. Crea el proyecto y sustituye/añade los archivos de la carpeta `Coste3D/` de este repo:
   - `Coste3DApp.swift`
   - `Views/ContentView.swift`
   - `Views/ResultCard.swift`
   - `Models/PrintJob.swift`
7. Pulsa Run (▶) en un simulador o en tu iPhone.

## Fórmulas

- Material = (gramos / 1000) × €/kg × (1 + merma%)
- Luz = (vatios / 1000) × horas × €/kWh
- Máquina = horas × €/hora de desgaste
- Mano de obra = minutos / 60 × €/hora
- Coste total = (material + luz + máquina + mano de obra + extras) × (1 + buffer%)
- Coste por pieza = coste total / piezas válidas
- Precio sugerido = coste por pieza / (1 - margen%)

Usa el peso y el tiempo que te da el slicer (Bambu Studio, Cura, PrusaSlicer, Orca).
