-- Создание таблиц (задание 2)

if object_id('dbo.SKU') is null
begin
    create table dbo.SKU (
        ID_SKU int not null identity,
        Code as 's' + cast(ID_SKU as varchar(255)),
        Name varchar(255) not null
    )
	alter table dbo.SKU add constraint UK_SKU_Code unique (Code)
end

if object_id('dbo.Family') is null
begin
    create table dbo.Family (
        ID_Family int not null identity,
        SurName varchar(255) not null,
        BudgetValue money not null
    )
end

if object_id('dbo.Basket') is null
begin
    create table dbo.Basket (
        ID_Basket int not null identity,
		ID_SKU int not null,
		ID_Family int not null,
		Quantity int not null,
		Value money not null,
		DatePurchase datetime not null,
		DiscountValue money not null
    )
	alter table dbo.Basket add constraint CK_Basket_Quantity check (Quantity >= 0)
	alter table dbo.Basket add constraint CK_Basket_Value check (Value >= 0)
	alter table dbo.Basket add constraint DF_Basket_DatePurchase default getdate() for DatePurchase
	alter table dbo.Basket add constraint FK_Basket_ID_SKU_SKU foreign key (ID_SKU) references dbo.SKU(ID_SKU)
	alter table dbo.Basket add constraint FK_Basket_ID_Family_Family foreign key (ID_Family) references dbo.Family(ID_Family)
end	