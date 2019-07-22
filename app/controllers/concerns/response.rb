module Response

  def json_response(object, status = :ok)
    render json: object, root: "data"
  end

end
