class TransferPolicy < TransactionPolicy 
    def show 
        user.present? && user==record.user
    end
    def edit
        user.present? && user==record.user
    end
    def destroy
        user.present? && user==record.user
    end
end