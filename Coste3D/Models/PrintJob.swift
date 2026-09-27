import Foundation
import SwiftUI

struct PrintJob {
    var productName: String
    var filamentPricePerKg: Double
    var gramsUsed: Double
    var wastePercent: Double
    var hours: Double
    var minutes: Double
    var printerWatts: Double
    var kwhPrice: Double
    var machineHourlyRate: Double
    var laborMinutes: Double
    var laborHourlyRate: Double
    var extraCosts: Double
    var failureBufferPercent: Double
    var quantity: Double
    var profitMarginPercent: Double

    var printHours: Double {
        max(0, hours) + max(0, minutes) / 60
    }

    var materialCost: Double {
        let raw = max(0, gramsUsed) / 1000 * max(0, filamentPricePerKg)
        return raw * (1 + max(0, wastePercent) / 100)
    }

    var electricityCost: Double {
        max(0, printerWatts) / 1000 * printHours * max(0, kwhPrice)
    }

    var machineCost: Double {
        printHours * max(0, machineHourlyRate)
    }

    var laborCost: Double {
        max(0, laborMinutes) / 60 * max(0, laborHourlyRate)
    }

    var baseCost: Double {
        materialCost + electricityCost + machineCost + laborCost + max(0, extraCosts)
    }

    var totalJobCost: Double {
        baseCost * (1 + max(0, failureBufferPercent) / 100)
    }

    var acceptedParts: Double {
        max(1, quantity)
    }

    var costPerPart: Double {
        totalJobCost / acceptedParts
    }

    var suggestedPricePerPart: Double {
        let margin = min(95, max(0, profitMarginPercent))
        return costPerPart / (1 - margin / 100)
    }

    var profitPerPart: Double {
        suggestedPricePerPart - costPerPart
    }
}
