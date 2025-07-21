class Tarefa < ApplicationRecord
    enum status: {
        em_andamento: "Em andamento",
        em_atraso: "Em atraso",
        concluido: "Concluído",
        cancelada: "Cancelada"
    }

    def verificar_atraso!
        if em_andamento? && data_de_entrega.present? && data_de_entrega < Date.today
            update(status: "Em atraso")
        end
    end
end
