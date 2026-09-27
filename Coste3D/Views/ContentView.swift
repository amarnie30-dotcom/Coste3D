import SwiftUI

struct ContentView: View {
    @AppStorage("filamentPrice") private var filamentPrice = 22.0
    @AppStorage("wastePercent") private var wastePercent = 10.0
    @AppStorage("printerWatts") private var printerWatts = 120.0
    @AppStorage("kwhPrice") private var kwhPrice = 0.20
    @AppStorage("machineRate") private var machineRate = 0.80
    @AppStorage("laborRate") private var laborRate = 18.0
    @AppStorage("failureBuffer") private var failureBuffer = 10.0
    @AppStorage("profitMargin") private var profitMargin = 40.0

    @State private var productName = ""
    @State private var gramsUsed = 80.0
    @State private var hours = 4.0
    @State private var minutes = 30.0
    @State private var laborMinutes = 20.0
    @State private var extraCosts = 0.0
    @State private var quantity = 1.0

    private var job: PrintJob {
        PrintJob(
            productName: productName,
            filamentPricePerKg: filamentPrice,
            gramsUsed: gramsUsed,
            wastePercent: wastePercent,
            hours: hours,
            minutes: minutes,
            printerWatts: printerWatts,
            kwhPrice: kwhPrice,
            machineHourlyRate: machineRate,
            laborMinutes: laborMinutes,
            laborHourlyRate: laborRate,
            extraCosts: extraCosts,
            failureBufferPercent: failureBuffer,
            quantity: quantity,
            profitMarginPercent: profitMargin
        )
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ResultCard(job: job)

                    inputCard("Pieza") {
                        TextField("Nombre del producto (opcional)", text: $productName)
                        numberRow("Peso del slicer (g)", value: $gramsUsed)
                        numberRow("Piezas válidas", value: $quantity)
                        HStack {
                            numberRow("Horas", value: $hours)
                            numberRow("Minutos", value: $minutes)
                        }
                    }

                    inputCard("Material y máquina") {
                        numberRow("Precio filamento (€/kg)", value: $filamentPrice)
                        numberRow("Merma / soportes (%)", value: $wastePercent)
                        numberRow("Consumo impresora (W)", value: $printerWatts)
                        numberRow("Luz (€/kWh)", value: $kwhPrice)
                        numberRow("Desgaste máquina (€/h)", value: $machineRate)
                    }

                    inputCard("Mano de obra y extra") {
                        numberRow("Minutos de trabajo", value: $laborMinutes)
                        numberRow("Tarifa laboral (€/h)", value: $laborRate)
                        numberRow("Extras (tornillos, caja...)", value: $extraCosts)
                        numberRow("Buffer fallos (%)", value: $failureBuffer)
                        numberRow("Margen de beneficio (%)", value: $profitMargin)
                    }

                    Text("Los valores de tarifas se guardan en el teléfono para no tener que repetirlos.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 4)
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Coste 3D")
        }
    }

    @ViewBuilder
    private func inputCard(_ title: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
            content()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16))
    }

    private func numberRow(_ title: String, value: Binding<Double>) -> some View {
        HStack {
            Text(title)
            Spacer()
            TextField("0", value: value, format: .number.precision(.fractionLength(0...2)))
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .frame(width: 90)
        }
    }
}

#Preview {
    ContentView()
}
