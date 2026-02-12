package shared.dto.objects

import kotlinx.serialization.Serializable
import shared.dto.objects.procedure.Complex
import shared.dto.objects.procedure.Procedure
import shared.dto.objects.procedure.Service
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import java.util.*

object Catalog {
    data object Responses {
        @Serializable
        data class Retrieve(
            val services: List<Service.Helpers.ServiceResponse>,
            val procedures: List<Procedure.Helpers.AllProcedureResponse>,
            val complexes: List<Complex.Helpers.ComplexResponse>,
        ) : Responsable
    }
}
