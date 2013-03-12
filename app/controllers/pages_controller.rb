class PagesController <  ApplicationController

  def show
    render params[:page_name]
  end

end
