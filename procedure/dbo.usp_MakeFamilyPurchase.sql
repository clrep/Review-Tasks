-- Создание хранимой процедуры (задание 5)

create or alter proc dbo.usp_MakeFamilyPurchase
	@FamilySurName varchar(255)
as 
	if @FamilySurName not in(select f.SurName from dbo.Family as f)
		print 'Error! This family does not exist!'
	else
	begin	
		begin transaction
			declare 
				@SumBasketValue int = 
					select sum(b.Value)
					from dbo.Family as f 
						inner join dbo.Basket as b on b.ID_Family = f.ID_Family
					where f.SurName = @FamilySurName
				
			update f
			set 
				f.BudgetValue -= @SumBasketValue 
			from dbo.Family as f
			where f.SurName = @FamilySurName
		commit transaction
	end