class Transfer

  attr_accessor :sender, :receiver, :status, :amount

  @@all = []
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
    @@all << self
  end

  def self.all 
    @@all
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    def reject_transfer
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
    if valid? && sender.balance > amount && self.status == "pending"
      sender.balance -= amount
      receiver.balance += amount
      self.status = "complete"
    else
      reject_transfer
    end
  end
    
  def reverse_transfer
    if valid? && receiver.balance > amount && self.status == "complete"
      receiver.balance -= amount
      sender.balance += amount
      self.status = "reversed"
    else
      reject_transfer
    end
  end
end
