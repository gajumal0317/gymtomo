module LoginSupport
  def login_rspec(user)
    # login userの代替
    # ActionDispatch::Requestクラスの全インスタンスに対して、sessionメソッドが呼ばれた場合に、user_idを返す
    post login_path, params: { session: { email: user.email,
                                      password: user.password } }
  end
end