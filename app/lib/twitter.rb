require 'selenium-webdriver'
require 'webdrivers'

class TwitterBase
    BASE_URL = 'https://twitter.com/i/flow/login'

    def initialize
        @driver = Selenium::WebDriver.for :chrome
        @wait = Selenium::WebDriver::Wait.new(:timeout => 30)
    end

    def login(account)
        @account = account
        open_twitter
        @error = enter_address(account[:name])
        if error_check(@error)
            return @error
        end
        @error = enter_password(account[:password])
        if error_check(@error) 
            return @error
        end
        @cookie = get_cookie(@driver)
        return nil
    end

    def following_def(name)
        open_my_profile(name)
        follow_count
        open_my_following(name)
        follow_list
    end

    def unfollow_def
        following_def(@account[:name])
        return @unfollow_list 
    end

    def unfollow(unfollow_list)
        base = Time.now
        @errors = []
        size = unfollow_list.size
        threads = []
        unfollow_list.each do |id|
            now = Time.now
            if now - base >= 15
                sleep 3
            end
            threads << Thread.new do
                driver = create_driver_with_cookie(@cookie,id)
                url = "https://twitter.com/#{id}"
                driver.get(url)
                sleep 1
                begin
                    begin
                        driver.find_element(:css,'#react-root > div > div > div.css-1dbjc4n.r-18u37iz.r-13qz1uu.r-417010 > main > div > div > div > div > div > div:nth-child(3) > div > div > div > div > div.css-1dbjc4n.r-1habvwh.r-18u37iz.r-1w6e6rj.r-1wtj0ep > div.css-1dbjc4n.r-obd0qt.r-18u37iz.r-1w6e6rj.r-1h0z5md.r-dnmrzs > div:nth-child(4) > div.css-1dbjc4n.r-6gpygo > div').click
                    rescue
                        begin
                            driver.find_element(:css,'#react-root > div > div > div.css-1dbjc4n.r-18u37iz.r-13qz1uu.r-417010 > main > div > div > div > div > div > div:nth-child(3) > div > div > div > div > div.css-1dbjc4n.r-1habvwh.r-18u37iz.r-1w6e6rj.r-1wtj0ep > div.css-1dbjc4n.r-obd0qt.r-18u37iz.r-1w6e6rj.r-1h0z5md.r-dnmrzs > div:nth-child(3) > div.css-1dbjc4n.r-6gpygo > div').click
                        rescue
                            driver.find_element(:css,'#react-root > div > div > div.css-1dbjc4n.r-18u37iz.r-13qz1uu.r-417010 > main > div > div > div > div > div > div:nth-child(3) > div > div > div > div > div.css-1dbjc4n.r-1habvwh.r-18u37iz.r-1w6e6rj.r-1wtj0ep > div.css-1dbjc4n.r-obd0qt.r-18u37iz.r-1w6e6rj.r-1h0z5md.r-dnmrzs > div:nth-child(2) > div.css-1dbjc4n.r-6gpygo > div').click             
                        end
                    end
                    sleep 1
                    @wait.until {  driver.find_element(:css,'#layers > div:nth-child(2) > div > div > div > div > div > div.css-1dbjc4n.r-1awozwy.r-1kihuf0.r-18u37iz.r-1pi2tsx.r-1777fci.r-1pjcn9w.r-xr3zp9.r-1xcajam.r-ipm5af.r-9dcw1g > div.css-1dbjc4n.r-z6ln5t.r-14lw9ot.r-1867qdf.r-1jgb5lz.r-pm9dpa.r-1rnoaur.r-494qqr.r-13qz1uu > div.css-1dbjc4n.r-eqz5dr.r-1hc659g.r-1n2ue9f.r-11c0sde.r-13qz1uu > div:nth-child(1)').displayed? }
                    driver.find_element(:css,'#layers > div:nth-child(2) > div > div > div > div > div > div.css-1dbjc4n.r-1awozwy.r-1kihuf0.r-18u37iz.r-1pi2tsx.r-1777fci.r-1pjcn9w.r-xr3zp9.r-1xcajam.r-ipm5af.r-9dcw1g > div.css-1dbjc4n.r-z6ln5t.r-14lw9ot.r-1867qdf.r-1jgb5lz.r-pm9dpa.r-1rnoaur.r-494qqr.r-13qz1uu > div.css-1dbjc4n.r-eqz5dr.r-1hc659g.r-1n2ue9f.r-11c0sde.r-13qz1uu > div:nth-child(1)').click
                rescue
                    @errors.push("#{id}はすでにフォローを外しています")
                end
                driver.quit
            end
        end
        threads.each(&:join)
        return @errors
    end

    def quit
        @driver.quit
    end

    private

    def get_cookie(driver)
        # ログイン後のCookieを取得
        cookie = driver.manage.all_cookies
        # Cookieをシリアライズして保存する必要がある場合はここで行う
        cookie
      end
      
      # CookieをセットしてWebDriverを作成する
      def create_driver_with_cookie(cookie,id)
        begin
            driver = Selenium::WebDriver.for :chrome
        rescue
            sleep 6
            port = [*9515..60000].sample
            Selenium::WebDriver::Chrome::Service.port = port
            driver = Selenium::WebDriver.for :chrome
        end
      
        driver.get "https://twitter.com/#{id}"
        # Cookieをセットする
        cookie.each do |c|
          driver.manage.add_cookie(c)
        end
        driver
    end

    def error_check(error)
        if !error.nil?
            return true
        else
            return false
        end
    end

    #def use_twitter_api
    #    @client = Twitter::REST::Client.new do |config|
    #        config.consumer_key        = @account[:consumer_key]
    #        config.consumer_secret     = @account[:consumer_secret]
    #        config.access_token        = @account[:access_token]
    #        config.access_token_secret = @account[:access_token_secret]
    #    end
    #end

    def wait_and_find_element(how,what)
        begin
            @wait.until {  @driver.find_element(how,what).displayed? }
            @driver.find_element(how,what)
        rescue
            return false
        end
    end


    def open_twitter
        @driver.get BASE_URL
        begin 
            wait_and_find_element(:tag_name,'input')
        rescue
            @driver.execute_script("window.close()")
            open_twitter
        end
    end

    def enter_address(name)
        element = wait_and_find_element(:tag_name,'input')
        element.send_keys(name)
        wait_and_find_element(:css,'#layers > div > div > div > div > div > div > div.css-1dbjc4n.r-1awozwy.r-18u37iz.r-1pi2tsx.r-1777fci.r-1xcajam.r-ipm5af.r-g6jmlv > div.css-1dbjc4n.r-1867qdf.r-1wbh5a2.r-kwpbio.r-rsyp9y.r-1pjcn9w.r-1279nm1.r-htvplk.r-1udh08x > div > div > div.css-1dbjc4n.r-14lw9ot.r-6koalj.r-16y2uox.r-1wbh5a2 > div.css-1dbjc4n.r-16y2uox.r-1wbh5a2.r-1jgb5lz.r-1ye8kvj.r-13qz1uu > div > div > div > div:nth-child(6)').click
        if !wait_and_find_element(:name,'password')
            @error = '名前または電話番号が正しいか確認してください'
            @driver.quit
            puts @error
        end
        return @error
    end

    def enter_password(password)
        element = wait_and_find_element(:name,'password')
        element.send_keys(password)
        wait_and_find_element(:css,'#layers > div > div > div > div > div > div > div.css-1dbjc4n.r-1awozwy.r-18u37iz.r-1pi2tsx.r-1777fci.r-1xcajam.r-ipm5af.r-g6jmlv > div.css-1dbjc4n.r-1867qdf.r-1wbh5a2.r-kwpbio.r-rsyp9y.r-1pjcn9w.r-1279nm1.r-htvplk.r-1udh08x > div > div > div.css-1dbjc4n.r-14lw9ot.r-6koalj.r-16y2uox.r-1wbh5a2 > div.css-1dbjc4n.r-16y2uox.r-1wbh5a2.r-1jgb5lz.r-1ye8kvj.r-13qz1uu > div.css-1dbjc4n.r-1isdzm1 > div > div.css-1dbjc4n > div > div > div').click
        if !wait_and_find_element(:css,'#react-root > div > div > div.css-1dbjc4n.r-18u37iz.r-13qz1uu.r-417010 > header > div > div > div > div:nth-child(1) > div.css-1dbjc4n.r-1awozwy.r-15zivkp.r-1bymd8e.r-13qz1uu > nav')
            @error = 'パスワードが正しいか確認してください'
            @driver.quit
            puts @error
        end
        return @error
    end

    def open_my_profile(name)
        @driver.get "https://twitter.com/#{name}"
    end

    def open_my_following(name)
        @driver.get "https://twitter.com/#{name}/following"
        wait_and_find_element(:css,'#react-root > div > div > div.css-1dbjc4n.r-18u37iz.r-13qz1uu.r-417010 > main > div > div > div > div > div > section')
        sleep 1
    end

    def follow_count
        element = wait_and_find_element(:css,'#react-root > div > div > div.css-1dbjc4n.r-18u37iz.r-13qz1uu.r-417010 > main > div > div > div > div > div > div:nth-child(3) > div > div > div > div.css-1dbjc4n.r-1ifxtd0.r-ymttw5.r-ttdzmv > div.css-1dbjc4n.r-13awgt0.r-18u37iz.r-1w6e6rj > div.css-1dbjc4n.r-1mf7evn > a > span.css-901oao.css-16my406.r-18jsvk2.r-poiln3.r-1b43r93.r-b88u0q.r-1cwl3u0.r-bcqeeo.r-qvutc0 > span')
        @follow_count = element.text.to_i
        puts "フォロー数：#{@follow_count}"
    end

    def follow_list
        @unfollow_list = {} 

        def get_y(selector)
            trans_y = wait_and_find_element(:css,"#{selector}").css_value('transform')

            #y座標取り出す
            follow_y = trans_y.delete("^0-9").to_i
            trash = 10010 #うえのトランスフォーム指定したときにいらんとこ
            digits = Math.log10(follow_y).to_i + 1 - 5 #最初ので桁数求めれてそっからごみの５けた分引く
            sub = 10**digits * trash
            follow_y = follow_y - sub
            #puts follow_y
            follow_y
        end

        def current_y_and_next(follow_y,i)
            @driver.execute_script("window.scrollTo(0,#{follow_y});")
                sleep 2
                current = 0
                for j in 1..i
                    y = get_y("#react-root > div > div > div.css-1dbjc4n.r-18u37iz.r-13qz1uu.r-417010 > main > div > div > div > div > div > section > div > div > div > div > div:nth-child(#{j})")
                    if y == follow_y
                        #puts j
                        current = j
                        return current
                    end
                end
        end
        i = 1
        people = 1
        while people <= @follow_count
            if i >= 37
                i = 36
                selector = "#react-root > div > div > div.css-1dbjc4n.r-18u37iz.r-13qz1uu.r-417010 > main > div > div > div > div > div > section > div > div > div > div > div:nth-child(#{i})"
                follow_y = get_y(selector)
                i = current_y_and_next(follow_y,i)
                i += 1

            end
            begin
                follow = @driver.find_element(:css,"#react-root > div > div > div.css-1dbjc4n.r-18u37iz.r-13qz1uu.r-417010 > main > div > div > div > div > div > section > div > div > div > div > div:nth-child(#{i})")
                @wait.until {  follow.find_element(:tag_name,'span').displayed? }
            rescue
                selector = "#react-root > div > div > div.css-1dbjc4n.r-18u37iz.r-13qz1uu.r-417010 > main > div > div > div > div > div > section > div > div > div > div > div:nth-child(#{i-1})"
                follow_y = get_y(selector)

                current = current_y_and_next(follow_y,i)
                i = current+1
                
                follow = @driver.find_element(:css,"#react-root > div > div > div.css-1dbjc4n.r-18u37iz.r-13qz1uu.r-417010 > main > div > div > div > div > div > section > div > div > div > div > div:nth-child(#{i})")
                @wait.until {  follow.find_element(:tag_name,'span').displayed? }
            end
            name = follow.find_element(:tag_name,'span')

            #フォローされてないか確認
            if unfollow_me_list(follow)
                id = follow.find_element(:css,'div > div > div > div > div.css-1dbjc4n.r-1iusvr4.r-16y2uox > div.css-1dbjc4n.r-1awozwy.r-18u37iz.r-1wtj0ep > div.css-1dbjc4n.r-1wbh5a2.r-dnmrzs.r-1ny4l3l > div > div.css-1dbjc4n.r-1awozwy.r-18u37iz.r-1wbh5a2 > div > a > div > div > span')
                @unfollow_list["#{name.text}"] = id.text #ko
                puts "#{name.text} : unfollows me"
            else
                puts name.text
            end

            i += 1
            people += 1
        end

    end

    def unfollow_me_list(follow)
        begin
            follow.find_element(:css,'div > div > div > div > div.css-1dbjc4n.r-1iusvr4.r-16y2uox > div.css-1dbjc4n.r-1awozwy.r-18u37iz.r-1wtj0ep > div.css-1dbjc4n.r-1wbh5a2.r-dnmrzs.r-1ny4l3l > div > div.css-1dbjc4n.r-1awozwy.r-18u37iz.r-1wbh5a2 > div.css-1dbjc4n.r-1awozwy.r-z2wwpe.r-6koalj.r-1q142lx')
        rescue
            return true
        end
        return false
    end
end
if __FILE__ == $PROGRAM_NAME
    twitter = TwitterBase.new
    account = {name:"yuma4869b",password:"twitter4869you"}
    twitter.login(account)
    twitter.unfollow_def
end
