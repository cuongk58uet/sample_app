class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.microposts.feed(current_user.id)
        .order_type.paginate page: params[:page],
        per_page: Settings.paginate.size
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
