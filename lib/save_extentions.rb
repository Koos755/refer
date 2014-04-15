module SaveExtentions

  def name=(name)
    user = self.user
    user.name = name
    user.save
  end

  def mobile=(mobile)
    user = self.user
    user.mobile = mobile
    user.save
  end

  def email=(email)
    user = self.user
    user.email = email
    user.save
  end

end
