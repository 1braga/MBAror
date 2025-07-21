class TarefasController < ApplicationController
    before_action :set_tarefa, only: [ :show, :update, :destroy ]
    def index
        tarefas = filtrar_tarefas
        tarefas.each(&:verificar_atraso!)
        render json: tarefas
    end

    def show
        return render json: { error: "Tarefa não encontrada" },
        status: :not_found unless @tarefa

        @tarefa.verificar_atraso!
        render json: @tarefa
    end

    def create
        tarefa = Tarefa.new(tarefa_params)
        if tarefa.save
            render json: tarefa, status: :created
        else
            render json: tarefa.errors, status: :unprocessable_entity
        end
    end

    def update
        if @tarefa.update(tarefa_params)
            render json: @tarefa
        else
            render json: @tarefa.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @tarefa.update(status: "Cancelada")
        render json: @tarefa
    end

    private

    def set_tarefa
        @tarefa = Tarefa.find_by(params[:id])
    end

    def tarefa_params
        params.require(:tarefa).permit(:titulo, :descricao, :status, :data_de_entrega)
    end

    def filtrar_tarefas
        tarefas = Tarefa.all

        tarefas = tarefas.where(status: params[:status]) if params[:status].present?
        tarefas = tarefas.where("titulo LIKE ?", "%#{params[:titulo]}%") if params[:titulo].present?
        tarefas = tarefas.where("descricao ILIKE ?", "%#{params[:descricao]}%") if params[:descricao].present?
        tarefas = tarefas.where("DATE(created_at) = ?", params[:data_criacao]) if params[:data_criacao].present?
        tarefas = tarefas.where(data_de_entrega: params[:data_entrega]) if params[:data_entrega].present?

        tarefas
    end
end
