class DayOfWeekController < ApplicationController
  def index
  end

  def get

    @year = params[:year].to_i
    @month = params[:month].to_i
    @day = params[:day].to_i

    if @month == 1 || @month == 2
      @month += 12
      @year  -= 1
    end
  
    # 曜日計算
    result = (@year + @year / 4 - @year / 100 + @year / 400 + (13 * @month + 8) / 5 + @day) % 7

    # 曜日を文字列で返す
    @day_of_week = %w(日曜日 月曜日 火曜日 水曜日 木曜日 金曜日 土曜日)[result]

    #公式の写真と、サマーウォーズの紹介と、c言語やruby、pythonでのコードの紹介と原理と証明とgithubへの誘導、余裕があれば数学本へのアフィリ栄5都とかもしたい

    render("day_of_week/index")
  end
end
