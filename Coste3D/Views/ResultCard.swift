import SwiftUI

struct ResultCard: View {
    let job: PrintJob

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(job.productName.isEmpty ? "Coste por pieza" : job.productName)
                    .font(.headline)
                Text(job.costPerPart, format: .currency(code: "EUR"))
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                Text("Precio sugerido: \(formatted(job.suggestedPricePerPart))")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Divider()

            row("Material", job.materialCost)
            row("Electricidad", job.electricityCost)
            row("Máquina / desgaste", job.machineCost)
            row("Mano de obra", job.laborCost)
            row("Extras", job.extraCosts)
            row("Trabajo completo", job.totalJobCost)
            row("Beneficio por pieza", job.profitPerPart)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                colors: [Color.orange.opacity(0.18), Color.cyan.opacity(0.12)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            in: RoundedRectangle(cornerRadius: 20)
        )
    }

    private func row(_ title: String, _ value: Double) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value, format: .currency(code: "EUR"))
                .monospacedDigit()
        }
        .font(.subheadline)
    }

    private func formatted(_ value: Double) -> String {
        value.formatted(.currency(code: "EUR"))
    }
}
