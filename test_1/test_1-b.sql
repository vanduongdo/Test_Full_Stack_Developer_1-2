-- 1. Ghi lại thông tin giao dịch trước khi chuyển tiền.
--     Ghi lại thông tin vào một bảng log. Giúp theo dõi và xác nhận các giao dịch đã thực hiện

-- 2. Thực hiện giao dịch chuyển tiền và luôn kiểm tra giao dịch có được update thành công hay không

-- 3. Ghi lại tất cả các hành động lỗi
--     Trong trường hợp giao dịch không thành công, ghi lại thông tin về lỗi vào bảng log để theo dõi và xử lý.

-- Cách làm
    -- Ghi lại thông tin vào một bảng log. Giúp theo dõi và xác nhận các giao dịch đã thực hiện
    INSERT INTO Transaction_Log (sender_account_id, recipient_account_id, amount, transaction_date)
    VALUES (@sender_account_id, @recipient_account_id, @amount, CURRENT_TIMESTAMP);

    -- Sử dụng Transaction trong SQL nêu một transaction bị lỗi và được rollback, thì tất cả các sửa đổi dữ liệu sẽ bị xóa (dữ liệu được khôi phục về trạng thái trước khi thực hiện transaction).
    BEGIN TRANSACTION; 

    -- Thực hiện trừ tiền từ tài khoản người gửi
    UPDATE VITIEN SET TIEN=3TI WHERE TEN=ANH A
    -- Kiểm tra xem trừ tiền từ tài khoản người gửi đã thành công hay không 
    IF @@ROWCOUNT = 0
    BEGIN
        ROLLBACK;
        -- Ghi log lỗi hoặc xử lý các hành động khác
        INSERT INTO Error_Log (error_message, transaction_date)
        VALUES ('Không thể trừ tiền từ tài khoản người gửi', CURRENT_TIMESTAMP);
    END
    ELSE
    BEGIN
        -- Thực hiện cộng tiền vào tài khoản người nhận
        UPDATE VITIEN SET TIEN=1TI WHERE TEN=CHỊ B
        -- Kiểm tra xem cộng tiền vào tài khoản người nhận đã thành công hay không
        IF @@ROWCOUNT = 0
        BEGIN
            ROLLBACK;
            -- Ghi log lỗi hoặc xử lý các hành động khác
            INSERT INTO Error_Log (error_message, transaction_date)
            VALUES ('Không thể cộng tiền vào tài khoản người nhận', CURRENT_TIMESTAMP);
        END
        ELSE
        BEGIN
            COMMIT;
        END
    END