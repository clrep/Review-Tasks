-- Создание триггера (задание 6)

create or alter trigger dbo.TR_Basket_insert_update on dbo.Basket
after insert
as
begin
	begin transaction
		declare
			@ID_Basket int
			,@ID_SKU int
			,@CountID_SKU int
			,@DiscountPercentage money
		
		select
			@ID_Basket = ID_Basket
			,@ID_SKU = ID_SKU
			,@CountID_SKU = count(*)
		from inserted
		group by ID_SKU
		
		if @CountID_SKU >= 2
			set @DiscountPercentage = 0.05
		else 
			set @DiscountPercentage = 0
		
		update b
		set DiscountValue = Value * @DiscountPercentage
		from dbo.Basket as b
		where ID_Basket = @ID_Basket
			and ID_SKU = @ID_SKU
	commit transaction
end
    

