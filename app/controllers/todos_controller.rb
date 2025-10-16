class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    todos = current_user.todos
    if todos.any?
      render json: { message: "Fetched todos successfully", todos: todos }, status: :ok
    else
      render json: { message: "No todos found" }, status: :ok
    end
  end

  # GET /todos/:id
  def show
    if @todo
      render json: { message: "Fetched todo successfully", todo: @todo }, status: :ok
    else
      render json: { message: "Todo not found" }, status: :not_found
    end
  end

  # POST /todos
  def create
    todo = current_user.todos.build(todo_params)
    if todo.save
      render json: { message: "Todo created successfully", todo: todo }, status: :created
    else
      render json: { message: "Todo creation failed", errors: todo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT or PATCH /todos/:id
  def update
    if @todo && @todo.update(todo_params)
      render json: { message: "Todo updated successfully", todo: @todo }, status: :ok
    elsif @todo.nil?
      render json: { message: "Todo not found" }, status: :not_found
    else
      render json: { message: "Todo update failed", errors: @todo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /todos/:id
  def destroy
    if @todo
      @todo.destroy
      render json: { message: "Todo deleted successfully" }, status: :ok
    else
      render json: { message: "Todo not found" }, status: :not_found
    end
  end

  private

  def set_todo
    @todo = current_user.todos.find_by(id: params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :description, :completed)
  end
end




# This line is added to test pull request
