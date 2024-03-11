-- Создание представления (задание 4)

if object_id('dbo.vw_SKUPrice') is null
begin
    create view dbo.vw_SKUPrice
		as
		select
			s.ID_SKU,
			s.Code,
			s.Name,
			dbo.udf_GetSKUPrice(ID_SKU) as Price	
        from dbo.SKU as s
end