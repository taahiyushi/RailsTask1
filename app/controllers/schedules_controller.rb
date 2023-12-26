class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]     #:show, :edit, :update, :destroy前にset_scheduleの処理を行う

  def index
    @schedules = Schedule.all     #すべてのスケジュールを取得して代入している
    @total_schedules = Schedule.count     #スケジュール数を代入している
    @today = Time.zone.now.in_time_zone('Asia/Tokyo').to_date     #日本の日にちを取得して代入している
  end

  def new     #新しいスケジュールを作成するためのフォームを表示するアクション
    @schedule = Schedule.new
  end

  def create     #新しいスケジュールを保存する。
    @schedule = Schedule.new(schedule_params)     #schedule_params メソッドはprivate定義している
    if @schedule.save     #保存に成功した場合はインデックスにリダイレクトしてそれ以外の場合は新しいフォームを再表示します。
      flash[:success] = 'スケジュールが作成されました'
      redirect_to schedules_path
    else
      render :new
    end
  end

  def show     #特定のスケジュールの詳細を表示する
  end

  def edit     # スケジュールを編集するためのフォームを表示する
  end

  def update     #スケジュールを更新する。更新に成功した場合インデックスにリダイレクトする。失敗した場合エディットに戻る
    if @schedule.update(schedule_params)     #ここでの@scheduleはschedule_paramsアクションで定義されたもの。　schedule_paramsは新たに入力されたパラメーター
      flash[:success] = 'スケジュールが更新されました'
      redirect_to schedules_path
    else
      render :edit
    end
  end

  def destroy     #スケジュールを削除し、インデックスにリダイレクトする
    @schedule.destroy
    flash[:success] = 'スケジュールが削除されました'
    redirect_to schedules_path
  end

  private     #以下外部からのアクセスはできないアクション

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def schedule_params     #ストロングパラメーターで不正なパラメーターやデータを回避する。それを通過したらパラメーターがcreate,updateアクションで用いられる
    params.require(:schedule).permit(:title, :start_date, :end_date, :all_day, :memo)     #formから送信されたデータにscheduleキーが存在している必要がある　
  end                                                                                     #permitはscheduleキー内のデータに対して許可された属性のみを選択する
end

