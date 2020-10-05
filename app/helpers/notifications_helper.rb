module NotificationsHelper
  
  def notification_form(notification)
    #通知を送ってきたユーザーを取得
    @visitor = notification.visitor
    #コメントの内容を通知に表示する
    @comment = nil
    @visitor_comment = notification.comment_id
    # notification.actionがfollowかlikeかcommentかで処理を変える
    case notification.action
    when 'follow'
      #aタグで通知を作成したユーザーshowのリンクを作成
      tag.a(notification.visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + 'があなたをフォローしました。'
    when 'like'
      tag.a(notification.visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + 'が' + tag.a('あなたの投稿', href: "#", style: "font-weight: bold;") + 'に「いいね！」しました。'
    when 'comment' then
      #コメントの内容と投稿のタイトルを取得　      
      @comment = Comment.find_by(id: notification.comment_id)&.comment
      @comment_content = @comment
      tag.a(@visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + 'が' + tag.a('あなたの投稿', href: "#", style: "font-weight: bold;") + 'にコメントしました。'
    end
  end
end
