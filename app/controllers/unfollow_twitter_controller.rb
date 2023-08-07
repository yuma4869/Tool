class UnfollowTwitterController < ApplicationController
  require_relative '../lib/twitter'

  def index
  end


  def account
    $errors = ["test"]
    puts "name is #{params[:name]}\npassword is #{params[:password]}"
    $account = {
      "name": params[:name],
      "password": params[:password]
    }
    $twitter = TwitterBase.new
    $errors.push($twitter.login($account))
    puts "#{$errors.size}#{$errors}"
    if $errors[1] == nil
      $unfollow_me_list = $twitter.unfollow_def
      puts 'フォローしてる中でフォローしてくれてない人'
    end
    
    $unfollow_list = []
    $follow = []

    redirect_to('/unfollow_twitter')
  end

  def unfollow_do
    $error_unfollow = $twitter.unfollow($unfollow_list)
    success = ($unfollow_list.size - $error_unfollow.size )
    flash[:notice] = "#{success}人のフォローを外すことに成功しました\n"
    if !$error_unfollow.nil?
      flash[:notice] << "#{$error_unfollow}"
    end
    
    $unfollow_list.each do |list|
      $unfollow_me_list.delete_if{|k,v|
        v == list
      }
    end
    $unfollow_list = []
    redirect_to('/unfollow_twitter')
  end

  def bulk_unfollow
    for i in params[:first]..params[:last]
      if $follow.any? {|v| $follow_list[i] == v}
        next
      end
      $unfollow_list.push($follow_list[i])
    end
    redirect_to('/unfollow_twitter')
  end

  def all_unfollow
    for i in "0"..$unfollow_me_list.size.to_s
      if $follow.any? {|v| $follow_list[i] == v}
        next
      end
      $unfollow_list.push($follow_list[i])
    end
    unfollow_do
  end

  def follow
    $follow.push(params[:id])
    if $unfollow_list.any? {|v| params[:id] == v}
      $unfollow_list.delete("#{params[:id]}")
    end
    redirect_to unfollow_twitter_path(anchor: params[:i])
  end

  def follow_to_unfollow
    $follow.delete(params[:id])
    redirect_to unfollow_twitter_path(anchor: params[:i])
  end

  def delete_unfollow
    $unfollow_list.delete("#{params[:list]}")
    redirect_to(unfollow_twitter_path)
  end
end
