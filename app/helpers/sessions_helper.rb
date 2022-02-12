module SessionsHelper
  # session eh um metodo do rails - cria um cookie temporario no brownser e expira ao fechar
  # esses cookies gerados pelo metodo session sao automaticamente encriptados
  def log_in(user)
    session[:user_id] = user.id
  end

  # usar o find_by que retorna nil - o find sobe um erro
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
    end
end
