class TasksController < ApplicationController

  include SessionsHelper

  before_action :current_user,only: [:index,:user_all_tasks,:random_all_tasks,:create]
  def index
    @random_tasks = Task.where("DATE(created_at) = ?", Date.today).order("RANDOM()")
    @message = "他の日のタスクを見る"
    @my_url = "tasks/user_all_tasks"
    @random_url = "tasks/random_all_tasks"
    if @current_user
      @tasks = @current_user.tasks.where("DATE(created_at) = ?", Date.today).rank(:row_order)
      @titles = []
      @times = []
    end
  end

  def user_all_tasks
    @tasks = @current_user.tasks.rank(:row_order)
    @random_tasks = Task.where("DATE(created_at) = ?", Date.today).order("RANDOM()")
    @message = "本日だけのタスクを見る"
    @my_url = "tasks"
    @titles = []
    @times = []
    render "tasks/index"
  end

  def random_all_tasks
    if @current_user
      @tasks = @current_user.tasks.where("DATE(created_at) = ?", Date.today).rank(:row_order)
    end
    @random_tasks = Task.order("RANDOM()")
    @message = "本日だけのタスクを見る"
    @random_url = "tasks"
    @titles = []
    @times = []
    render "tasks/index"
  end

  def show
    user_id = User.where(name: params[:name]).pluck(:id).first
    if user_id.nil?
      flash[:notice] = "指定のユーザー名の人が見つかりませんでした"
      render 'tasks/index'
    else
      @tasks = Task.where(user_id: user_id)
    end
  end

  def total
    user_id = User.where(name: params[:name]).pluck(:id).first
    if user_id.nil?
      flash[:notice] = "指定のユーザー名の人が見つかりませんでした"
      render 'tasks/index'
    else
      @tasks = Task.where(user_id: user_id)
      # 一番最初のcreated_atを取得
      @first_created_at = @tasks.order(:created_at).pluck(:created_at).first

      # 一番最後のcreated_atを取得
      @last_created_at = @tasks.order(:created_at).pluck(:created_at).last
      title_times = Hash.new(0)
      @tasks.each do |task|
        title_times[task.title] += task.time.to_i
      end
      @titles,@times = title_times.keys,title_times.values
    end
  end

  def create
    task_params[:title].each_with_index do |title,index|
      content = task_params[:content][index]
      time = task_params[:time][index]

      task = @current_user.tasks.new(name: params[:name],title: title,content: content,time: time)
      begin task.save!
        @tasks = task
        redirect_to "/tasks"

      rescue ActiveRecord::RecordInvalid => e
        flash[:error] = "タイトルと名前は英数字で特殊文字列を使わず入力してください。時間は半角数字で入力してください。すべての項目は必須です"
        logger.error "タスクの保存に失敗しました。エラーメッセージ：#{e.message}"
        redirect_to "/tasks"
      end
    end
  end

  def update
    @task = target_task params[:id]
    @task.update(task_params)
    render "tasks/index"
  end

  def delete
    task = @current_user.tasks.where(id: params[:id]).take
    task.destroy
    redirect_to '/tasks'
    #   redirect_to '/tasks'
    # else
    #   flash[:notice] = '削除に失敗'
    #   render 'tasks/index'
    # end
  end

  def destroy
    for i in 56..61
      task = Task.find_by(id: i)
      task.destroy
    end
  end

  def sort
    puts params[:task][:row_order_position]
    puts sort_task_params
    @sort_task = Task.find(params[:id])
    @sort_task.update(sort_task_params)
    render body: nil
  end
  

private
  def target_task task_id
    @current_user.tasks.where(id: task_id).take
  end

  def task_params
    params.permit(:row_order_position,:name,title: [], content: [], time: [] )
  end

  def sort_task_params
    params.require(:task).permit(:row_order_position,:name,title: [], content: [], time: []) 
  end
end
