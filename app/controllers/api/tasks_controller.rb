class Api::TasksController < ApplicationController
    # GET /tasks
    def index
        @tasks = Task.order('update_at DESC')
    end

    def create
        @task = Task.new(task_param)
        if @task.save
            render :show, status: :created
        else
            render json: @task.errors, status: :unprocessable_entity
        end
    end

    def update
        @task = Task.find(params[:id])
        if @task.update(task_params)
            render :show, status: :ok
        else
            render json: @task.errors, status: :unprocessable_entity
        end
    end

    private
    # ホワイトリストのみ通過
        def task_params
            params.fetch(:task, {}).permit(
                :name, :is_done
            )
        end
end

